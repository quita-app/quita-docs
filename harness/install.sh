#!/usr/bin/env bash
# Installs the agent harness kit into a freshly generated code repo.
# Usage (from the folder that contains all Quita repos):
#   bash quita-docs/harness/install.sh <repo-name>
# Never overwrites an existing file.
set -euo pipefail

repo="${1:?usage: install.sh <quita-backend-api|quita-backoffice-web|quita-debtor-portal-web>}"
kit_name="${repo#quita-}"
script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
kit="$script_dir/$kit_name"
target="$(cd "$script_dir/../.." && pwd)/$repo"

[ -d "$kit" ] || { echo "No kit for '$repo' at $kit"; exit 1; }
[ -d "$target/.git" ] || { echo "'$target' is not a git repo yet. Generate it with the CLI first."; exit 1; }

copy() {  # copy <source> <destination>, skipping existing files
  if [ -e "$2" ]; then echo "skip   ${2#$target/} (already exists)"; else mkdir -p "$(dirname "$2")"; cp "$1" "$2"; echo "create ${2#$target/}"; fi
}

for file in AGENTS.md CLAUDE.md .env.example; do
  [ -f "$kit/$file" ] && copy "$kit/$file" "$target/$file"
done

while IFS= read -r -d '' file; do
  copy "$file" "$target/.claude/${file#$kit/dot-claude/}"
done < <(find "$kit/dot-claude" -type f -print0)

marker="# Quita harness"
if ! grep -qF "$marker" "$target/.gitignore" 2>/dev/null; then
  { echo; cat "$kit/gitignore.snippet"; } >> "$target/.gitignore"
  echo "append .gitignore"
else
  echo "skip   .gitignore (snippet already there)"
fi

echo "Done. Review AGENTS.md (versions and commands), then commit: chore: add agent harness"
