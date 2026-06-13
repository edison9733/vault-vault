#!/opt/homebrew/bin/python3
"""
ds_agent.py — DeepSeek agent loop with file-system tools.
Drop-in replacement for: claude -p PROMPT --output-format json --allowedTools ...

CLI:
  python3 ds_agent.py --cwd DIR --prompt TEXT [--tools LIST] [--max-turns N] [--output-json FILE]

Tools available: Read, Write, Edit, Glob, Grep, WebFetch, Move
"""
import argparse
import json
import os
import re
import shutil
import subprocess
import sys
import glob as glob_module
import urllib.request
import urllib.error
from pathlib import Path

_HOME = Path.home().resolve()


# ── Path safety ────────────────────────────────────────────────────────────────

def _safe_path(path_str: str, cwd: str) -> Path | None:
    """Resolve path; return None if it escapes $HOME."""
    expanded = os.path.expanduser(path_str)
    if os.path.isabs(expanded):
        resolved = Path(expanded).resolve()
    else:
        resolved = (Path(cwd) / expanded).resolve()
    try:
        resolved.relative_to(_HOME)
        return resolved
    except ValueError:
        return None


# ── Tool implementations ───────────────────────────────────────────────────────

def tool_read(args: dict, cwd: str) -> str:
    p = _safe_path(args.get("file_path", ""), cwd)
    if p is None:
        return "Error: path outside $HOME"
    if not p.exists():
        return f"Error: not found: {p}"
    try:
        content = p.read_text(encoding="utf-8", errors="ignore")
        if len(content) > 24000:
            content = content[:24000] + "\n...[truncated at 24000 chars]"
        return content
    except Exception as e:
        return f"Error reading: {e}"


def tool_write(args: dict, cwd: str) -> str:
    p = _safe_path(args.get("file_path", ""), cwd)
    if p is None:
        return "Error: path outside $HOME"
    try:
        p.parent.mkdir(parents=True, exist_ok=True)
        p.write_text(args.get("content", ""), encoding="utf-8")
        return f"Written: {p}"
    except Exception as e:
        return f"Error writing: {e}"


def tool_edit(args: dict, cwd: str) -> str:
    p = _safe_path(args.get("file_path", ""), cwd)
    if p is None:
        return "Error: path outside $HOME"
    if not p.exists():
        return f"Error: not found: {p}"
    old = args.get("old_string", "")
    new = args.get("new_string", "")
    try:
        content = p.read_text(encoding="utf-8", errors="ignore")
        if old not in content:
            return f"Error: old_string not found in {p.name}"
        p.write_text(content.replace(old, new, 1), encoding="utf-8")
        return f"Edited: {p}"
    except Exception as e:
        return f"Error editing: {e}"


def tool_glob(args: dict, cwd: str) -> str:
    pattern = args.get("pattern", "*")
    sub = args.get("path", "")
    root = str(Path(cwd) / sub) if sub else cwd
    try:
        matches = sorted(glob_module.glob(os.path.join(root, pattern), recursive=True))
        rel = [os.path.relpath(m, cwd) for m in matches]
        return "\n".join(rel) if rel else "(no matches)"
    except Exception as e:
        return f"Error in glob: {e}"


def tool_grep(args: dict, cwd: str) -> str:
    pattern = args.get("pattern", "")
    path = args.get("path", ".")
    include = args.get("include", "")
    search_path = str(Path(cwd) / path) if not os.path.isabs(path) else path
    cmd = ["grep", "-r", "-l", "--", pattern, search_path]
    if include:
        cmd.extend(["--include", include])
    try:
        r = subprocess.run(cmd, capture_output=True, text=True, timeout=30)
        lines = [l for l in r.stdout.strip().split("\n") if l]
        rel = [os.path.relpath(l, cwd) for l in lines]
        return "\n".join(rel) if rel else "(no matches)"
    except Exception as e:
        return f"Error in grep: {e}"


def tool_webfetch(args: dict, cwd: str) -> str:
    url = args.get("url", "")
    if not url.startswith(("http://", "https://")):
        return "Error: only http/https URLs allowed"
    try:
        req = urllib.request.Request(url, headers={"User-Agent": "Mozilla/5.0"})
        with urllib.request.urlopen(req, timeout=20) as r:
            raw = r.read().decode("utf-8", errors="ignore")
        raw = re.sub(r"<script[^>]*>.*?</script>", "", raw, flags=re.DOTALL | re.I)
        raw = re.sub(r"<style[^>]*>.*?</style>", "", raw, flags=re.DOTALL | re.I)
        raw = re.sub(r"<[^>]+>", "", raw)
        raw = re.sub(r"\s+", " ", raw).strip()
        return raw[:12000] if len(raw) > 12000 else raw
    except Exception as e:
        return f"Error fetching: {e}"


def tool_move(args: dict, cwd: str) -> str:
    src = _safe_path(args.get("source", ""), cwd)
    dst_str = os.path.expanduser(args.get("destination", ""))
    if not os.path.isabs(dst_str):
        dst = Path(cwd) / dst_str
    else:
        dst = Path(dst_str)
    try:
        dst_resolved = dst.resolve()
        dst_resolved.relative_to(_HOME)
    except ValueError:
        return "Error: destination outside $HOME"
    if src is None:
        return "Error: source outside $HOME"
    if not src.exists():
        return f"Error: source not found: {src}"
    try:
        dst_resolved.parent.mkdir(parents=True, exist_ok=True)
        shutil.move(str(src), str(dst_resolved))
        return f"Moved: {src} → {dst_resolved}"
    except Exception as e:
        return f"Error moving: {e}"


TOOL_DISPATCH = {
    "Read": tool_read,
    "Write": tool_write,
    "Edit": tool_edit,
    "Glob": tool_glob,
    "Grep": tool_grep,
    "WebFetch": tool_webfetch,
    "Move": tool_move,
}

TOOL_SCHEMAS = {
    "Read": {"type": "function", "function": {
        "name": "Read",
        "description": "Read the full contents of a file.",
        "parameters": {"type": "object",
                       "properties": {"file_path": {"type": "string", "description": "Relative or absolute path"}},
                       "required": ["file_path"]},
    }},
    "Write": {"type": "function", "function": {
        "name": "Write",
        "description": "Write content to a file, creating parent directories as needed.",
        "parameters": {"type": "object",
                       "properties": {"file_path": {"type": "string"},
                                      "content": {"type": "string"}},
                       "required": ["file_path", "content"]},
    }},
    "Edit": {"type": "function", "function": {
        "name": "Edit",
        "description": "Replace the first occurrence of old_string with new_string in a file.",
        "parameters": {"type": "object",
                       "properties": {"file_path": {"type": "string"},
                                      "old_string": {"type": "string"},
                                      "new_string": {"type": "string"}},
                       "required": ["file_path", "old_string", "new_string"]},
    }},
    "Glob": {"type": "function", "function": {
        "name": "Glob",
        "description": "List files matching a glob pattern. Returns newline-separated relative paths.",
        "parameters": {"type": "object",
                       "properties": {"pattern": {"type": "string", "description": "e.g. 'raw/*.md'"},
                                      "path": {"type": "string", "description": "Subdirectory to search (optional)"}},
                       "required": ["pattern"]},
    }},
    "Grep": {"type": "function", "function": {
        "name": "Grep",
        "description": "Find files containing a text pattern. Returns newline-separated file paths.",
        "parameters": {"type": "object",
                       "properties": {"pattern": {"type": "string"},
                                      "path": {"type": "string", "description": "Directory or file to search"},
                                      "include": {"type": "string", "description": "Filename filter e.g. '*.md'"}},
                       "required": ["pattern"]},
    }},
    "WebFetch": {"type": "function", "function": {
        "name": "WebFetch",
        "description": "Fetch text content from a URL (HTML stripped, 12000 char limit).",
        "parameters": {"type": "object",
                       "properties": {"url": {"type": "string"}},
                       "required": ["url"]},
    }},
    "Move": {"type": "function", "function": {
        "name": "Move",
        "description": "Move a file or directory to a new location.",
        "parameters": {"type": "object",
                       "properties": {"source": {"type": "string", "description": "Source path"},
                                      "destination": {"type": "string", "description": "Destination path"}},
                       "required": ["source", "destination"]},
    }},
}


# ── DeepSeek API ───────────────────────────────────────────────────────────────

def _call_api(messages: list, tool_defs: list, api_key: str, base_url: str, model: str) -> dict:
    url = base_url.rstrip("/") + "/v1/chat/completions"
    payload: dict = {
        "model": model,
        "messages": messages,
        "max_tokens": 8000,
        "temperature": 0.2,
    }
    if tool_defs:
        payload["tools"] = tool_defs
        payload["tool_choice"] = "auto"
    data = json.dumps(payload).encode("utf-8")
    req = urllib.request.Request(url, data=data, headers={
        "Content-Type": "application/json",
        "Authorization": f"Bearer {api_key}",
    })
    try:
        with urllib.request.urlopen(req, timeout=120) as r:
            return json.loads(r.read().decode("utf-8"))
    except urllib.error.HTTPError as e:
        body = e.read().decode("utf-8", errors="replace")
        raise RuntimeError(f"HTTP {e.code}: {body}")
    except urllib.error.URLError as e:
        raise RuntimeError(f"Network error: {e.reason}")


# ── Agent loop ─────────────────────────────────────────────────────────────────

def run_agent(
    prompt: str,
    cwd: str,
    enabled_tools: list[str],
    max_turns: int,
    api_key: str,
    base_url: str,
    model: str,
    log_fn,
) -> tuple[str, int]:
    tool_defs = [TOOL_SCHEMAS[t] for t in enabled_tools if t in TOOL_SCHEMAS]
    messages: list[dict] = [{"role": "user", "content": prompt}]
    final_text = ""
    num_turns = 0

    for turn in range(max_turns):
        num_turns = turn + 1
        log_fn(f"  turn {num_turns} (history: {len(messages)} msgs)")
        resp = _call_api(messages, tool_defs, api_key, base_url, model)
        choice = resp["choices"][0]
        msg = choice["message"]

        assistant_entry: dict = {"role": "assistant", "content": msg.get("content") or ""}
        if msg.get("tool_calls"):
            assistant_entry["tool_calls"] = msg["tool_calls"]
        messages.append(assistant_entry)

        if not msg.get("tool_calls"):
            final_text = msg.get("content", "")
            break

        for tc in msg["tool_calls"]:
            name = tc["function"]["name"]
            try:
                args = json.loads(tc["function"]["arguments"])
            except json.JSONDecodeError:
                args = {}

            if name in TOOL_DISPATCH and name in enabled_tools:
                result = TOOL_DISPATCH[name](args, cwd)
                first_arg = list(args.values())[0] if args else ""
                log_fn(f"    {name}({str(first_arg)[:60]!r}) → {len(str(result))} chars")
            else:
                result = f"Error: tool '{name}' not available in this run"

            messages.append({
                "role": "tool",
                "tool_call_id": tc["id"],
                "content": str(result),
            })

    return final_text, num_turns


# ── Main ──────────────────────────────────────────────────────────────────────

def main() -> None:
    parser = argparse.ArgumentParser(description="DeepSeek agent with file-system tools")
    parser.add_argument("--cwd", required=True, help="Working directory for file operations")
    parser.add_argument("--prompt", required=True, help="Initial user prompt")
    parser.add_argument("--tools", default="Read,Write,Edit,Glob,Grep",
                        help="Comma-separated list of enabled tools")
    parser.add_argument("--max-turns", type=int, default=40)
    parser.add_argument("--output-json", default="", help="Write JSON result to this file")
    args = parser.parse_args()

    api_key = os.environ.get("DEEPSEEK_API_KEY", "")
    if not api_key:
        print("FATAL: DEEPSEEK_API_KEY not set", file=sys.stderr)
        sys.exit(1)

    model = os.environ.get("DEEPSEEK_MODEL", "deepseek-chat")
    base_url = os.environ.get("DEEPSEEK_BASE_URL", "https://api.deepseek.com")
    enabled_tools = [t.strip() for t in args.tools.split(",") if t.strip()]

    cwd = os.path.abspath(args.cwd)

    def log_fn(msg: str) -> None:
        print(msg, file=sys.stderr)

    is_error = False
    result_text = ""
    num_turns = 0

    try:
        result_text, num_turns = run_agent(
            args.prompt, cwd, enabled_tools, args.max_turns,
            api_key, base_url, model, log_fn
        )
    except RuntimeError as e:
        is_error = True
        result_text = str(e)
        print(f"Agent error: {e}", file=sys.stderr)

    output = {
        "type": "result",
        "subtype": "success",
        "is_error": is_error,
        "num_turns": num_turns,
        "result": result_text,
        "session_id": "",
        "total_cost_usd": 0,
        "api_error_status": None,
    }

    output_str = json.dumps(output, indent=2, ensure_ascii=False)
    if args.output_json:
        Path(args.output_json).write_text(output_str + "\n", encoding="utf-8")
    else:
        print(output_str)

    sys.exit(1 if is_error else 0)


if __name__ == "__main__":
    main()
