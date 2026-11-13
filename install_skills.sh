#!/bin/bash -e
# Verlinkt alle Skills aus dotfiles/skills nach ~/.claude/skills

DOTFILES="$(cd "$(dirname "$0")" && pwd)"
mkdir -p ~/.claude/skills

for dir in "$DOTFILES"/skills/*/; do
  name=$(basename "$dir")
  ln -sfn "${dir%/}" ~/.claude/skills/"$name"
  echo "linked $name"
done
