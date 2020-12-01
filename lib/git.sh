function current_branch () {
  local folder="$(pwd)"
  [ -n "$1"  ] && folder="$1"
  git -C "$folder" rev-parse --abbrev-ref HEAD | grep -v HEAD || \
  git -C "$folder" describe --tags HEAD || \
  git -C "$folder" rev-parse HEAD
}

