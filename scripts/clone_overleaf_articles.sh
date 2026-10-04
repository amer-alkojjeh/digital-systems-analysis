#!/bin/bash
set -euo pipefail

: "${OVERLEAF_GIT_TOKEN:?OVERLEAF_GIT_TOKEN is not set}"

rm -rf articles
mkdir -p articles

while read -r project_id folder; do
  [[ -z "${project_id:-}" ]] && continue
  [[ "$project_id" == \#* ]] && continue
  [[ -z "${folder:-}" ]] && {
    echo "Invalid entry in overleaf_repos.txt"
    exit 1
  }

  echo "Cloning $folder"

  git clone \
    "https://git:${OVERLEAF_GIT_TOKEN}@git.overleaf.com/${project_id}" \
    "articles/$folder"

done < overleaf_repos.txt