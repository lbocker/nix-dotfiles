#!/usr/bin/env bash

resolve_dotfiles_host() {
  local repo_root="${1:?missing repo root}"
  local alias_file="${DOTFILES_HOST_ALIAS_FILE:-$repo_root/.local/host-alias}"

  if [[ -n "${DOTFILES_HOST_ALIAS:-}" ]]; then
    printf '%s\n' "$DOTFILES_HOST_ALIAS"
    return 0
  fi

  if [[ -f "$alias_file" ]]; then
    local alias
    alias="$(
      awk '
        /^[[:space:]]*#/ { next }
        /^[[:space:]]*$/ { next }
        {
          gsub(/^[[:space:]]+|[[:space:]]+$/, "", $0)
          print
          exit
        }
      ' "$alias_file"
    )"

    if [[ -n "$alias" ]]; then
      printf '%s\n' "$alias"
      return 0
    fi
  fi

  hostname -s 2>/dev/null || hostname
}
