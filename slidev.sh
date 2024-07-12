#!/bin/bash

case "$1" in
  build)
    for i in $(ls slides/*.md | xargs -I{} basename {} .md)
      do slidev build ./slides/$i.md -d --base /slides/$i/ --out ../dist/$i/
    done
  ;;
  dev)
  slidev --open ./slides/$2.md
  # "${@:2}"
  ;;
  export)
  mkdir -p pdf
    for i in $(ls slides/*.md | sed 's/slides\/\|\.md//g')
      do slidev export ./slides/$i.md --output ./pdf/$i.pdf --timeout 1000000
    done
  ;;
  *)
  ;;
esac
