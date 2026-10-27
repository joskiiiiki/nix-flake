#!/bin/sh
# Thin launcher around the raw intellij-server binary: on a normal run it
# needs --stdio/--system-path/--eula/--region/--data-sharing filled in, since
# an LSP client (Helix) only knows to run `intellij-server`. The binary
# itself already implements --show-eula/--version/--reset-eula and persists
# EULA acceptance after the first run that passes a matching --eula hash, so
# those pass straight through unmodified.
set -eu

self=$(readlink -f "$0")
server_dir="$(dirname "$self")/../libexec/intellij-server"

cache_home=${XDG_CACHE_HOME:-"$HOME/.cache"}
launcher="$server_dir/bin/intellij-server"
eula="$server_dir/EULA.txt"

case ${1:-} in
  --show-eula|--version|--reset-eula|-h|--help)
    exec "$launcher" "$@"
    ;;
esac

case ${INTELLIJ_LSP_REGION:-americas} in
  africa|americas|apac|china|europe|middle_east|oceania) ;;
  *) printf '%s\n' "Invalid INTELLIJ_LSP_REGION: ${INTELLIJ_LSP_REGION}" >&2; exit 2 ;;
esac

case ${INTELLIJ_LSP_DATA_SHARING:-none} in
  none|anonymous|full|test) ;;
  *) printf '%s\n' "Invalid INTELLIJ_LSP_DATA_SHARING: ${INTELLIJ_LSP_DATA_SHARING}" >&2; exit 2 ;;
esac

eula_hash=$(sha256sum "$eula" | cut -c1-16)
workspace_id=$(printf '%s' "$(pwd -P)" | cksum | awk '{print $1}')
system_path="$cache_home/jetbrains-intellij-lsp/workspaces/$workspace_id"
mkdir -p "$system_path"

exec "$launcher" \
  --stdio \
  --system-path "$system_path" \
  --eula "$eula_hash" \
  --region "${INTELLIJ_LSP_REGION:-americas}" \
  --data-sharing "${INTELLIJ_LSP_DATA_SHARING:-none}" \
  "$@"
