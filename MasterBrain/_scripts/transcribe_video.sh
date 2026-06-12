#!/bin/bash
# transcribe_video.sh - MANUAL Whisper fallback for videos with no captions.
# Usage: transcribe_video.sh <youtube-url-or-video-id>
# Downloads audio, transcribes locally on your M1 (mlx-whisper), drops the
# .srt into Vault-YouTube/raw/ so the next hourly run writes its note.
export PATH="/opt/homebrew/bin:/usr/local/bin:$PATH"
set -uo pipefail
[ $# -ge 1 ] || { echo "Usage: $0 <youtube-url-or-video-id>" >&2; exit 1; }
IN="$1"; case "$IN" in http*) URL="$IN";; *) URL="https://www.youtube.com/watch?v=$IN";; esac
RAW="$HOME/Vault-YouTube/raw"; TMP="$(mktemp -d)"; trap 'rm -rf "$TMP"' EXIT

command -v yt-dlp >/dev/null 2>&1 || { echo "FATAL: yt-dlp missing" >&2; exit 1; }
if ! command -v mlx_whisper >/dev/null 2>&1; then
  echo "==> Installing mlx-whisper (one time, Apple-Silicon optimized)..."
  command -v uv >/dev/null 2>&1 || brew install uv
  uv tool install mlx-whisper || { echo "FATAL: install failed. Try: pip3 install mlx-whisper --break-system-packages" >&2; exit 1; }
fi

echo "==> Downloading audio (smallest format)..."
yt-dlp -f "ba[abr<70]/ba" -x --audio-format m4a \
  -o "$TMP/%(upload_date>%Y-%m-%d)s - %(title).80s [%(id)s].%(ext)s" "$URL"
AUDIO="$(ls "$TMP"/*.m4a | head -1)"
[ -f "$AUDIO" ] || { echo "FATAL: audio download failed" >&2; exit 1; }

echo "==> Transcribing on-device (a 30-min video takes ~3-5 min on M1 Pro)..."
mlx_whisper "$AUDIO" --model mlx-community/whisper-small-mlx \
  --output-format srt --output-dir "$TMP"
SRT="$(ls "$TMP"/*.srt | head -1)"
[ -f "$SRT" ] || { echo "FATAL: transcription produced no srt" >&2; exit 1; }

BASE="$(basename "$AUDIO" .m4a)"
cp "$SRT" "$RAW/$BASE.srt"
echo "==> Done: $RAW/$BASE.srt"
echo "    The next hourly run will write its analysis note automatically"
echo "    (or run now: ~/Vault-YouTube/_scripts/yt_pipeline.sh)"
