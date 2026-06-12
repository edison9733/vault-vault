#!/bin/bash
# rsshub_start.sh - Start self-hosted RSSHub for Twitter scraping.
# 1) Make a THROWAWAY X account (never your real one - bans happen).
# 2) Log in at x.com -> DevTools (Cmd+Opt+I) -> Application -> Cookies
#    -> https://x.com -> copy values of: auth_token  and  ct0
# 3) Paste below, then run:  bash rsshub_start.sh
AUTH_TOKEN="a478bfe2b89cde8f0311a5dc4b8a4bc550d86ac2"
CT0="f3c51fafe52ce9da5d65e71d83f0b828821d7039123c196baf535352612152c89abda5df750bdef3e7383d2058b5320a3ff1a9504696845d30f20742939d0ff374ec4c4399b8ea2c76743b425c02be35"

if [ "$AUTH_TOKEN" = "PASTE_AUTH_TOKEN_HERE" ]; then
  echo "Edit this file first: paste your auth_token and ct0." >&2; exit 1
fi
command -v docker >/dev/null 2>&1 || { echo "Install Docker Desktop first: https://www.docker.com/products/docker-desktop/" >&2; exit 1; }

docker rm -f rsshub 2>/dev/null
# Both env vars on purpose: RSSHub has switched between them across releases.
docker run -d --name rsshub --restart unless-stopped -p 1200:1200 \
  -e TWITTER_COOKIE="auth_token=${AUTH_TOKEN}; ct0=${CT0}" \
  -e TWITTER_AUTH_TOKEN="${AUTH_TOKEN}" \
  -e CACHE_EXPIRE=3600 \
  diygod/rsshub:chromium-bundled

echo "Waiting 15s for startup..."; sleep 15
echo "Test:"; curl -s -o /dev/null -w "HTTP %{http_code}\n" "http://localhost:1200/twitter/user/OpenAI"
echo "200 = working. 403/503 = cookie problem or X blocking; re-check tokens."
