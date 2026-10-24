#!/usr/bin/env bash
# Re-apply the single-line pink lyric patch to media-lyrics' desktop widget.
# Idempotent: cmp-guarded so a re-apply never re-triggers the path unit.
set -euo pipefail

SRC="$HOME/.config/noctalia/media-lyrics-desktop.luau"
DST_DIR="$HOME/.local/state/noctalia/plugins/materialized/community/media-lyrics"
DST="$DST_DIR/desktop.luau"

[ -f "$SRC" ] || { echo "patch source missing: $SRC" >&2; exit 1; }
[ -d "$DST_DIR" ] || exit 0

if ! cmp -s "$SRC" "$DST"; then
  cp -f "$SRC" "$DST"
fi
