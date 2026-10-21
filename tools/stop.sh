#!/usr/bin/env bash
# Stop this project's Jekyll preview server on port 4000.

set -euo pipefail

if [[ $# -gt 0 ]]; then
  echo "Usage: bash tools/stop.sh"
  if [[ $# -eq 1 && ( $1 == --help || $1 == -h ) ]]; then
    exit 0
  fi
  exit 1
fi

project_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd -P)"

if ! command -v lsof >/dev/null 2>&1; then
  echo "Error: lsof is required to find the preview server." >&2
  exit 1
fi

pids="$(lsof -nP -tiTCP:4000 -sTCP:LISTEN || true)"
if [[ -z $pids ]]; then
  echo "No preview server is running on port 4000."
  exit 0
fi

for pid in $pids; do
  server_command="$(ps -p "$pid" -o args=)"
  server_dir="$(lsof -a -p "$pid" -d cwd -Fn | sed -n 's/^n//p')"

  # Also recognize servers started from tools/ before run.sh changed directories.
  if [[ ( $server_dir != "$project_dir" && $server_dir != "$project_dir/tools" ) || ! $server_command =~ [/]jekyll[[:space:]]+(s|serve)([[:space:]]|$) ]]; then
    echo "Error: port 4000 is used by another process; leaving it running." >&2
    exit 1
  fi
done

for pid in $pids; do
  kill -INT "$pid"
  for ((attempt = 0; attempt < 50; attempt++)); do
    if ! kill -0 "$pid" 2>/dev/null; then
      break
    fi
    sleep 0.1
  done
  if kill -0 "$pid" 2>/dev/null; then
    echo "Error: preview server (PID $pid) has not stopped yet; retry shortly." >&2
    exit 1
  fi
  echo "Stopped the preview server (PID $pid)."
done
