#!/bin/bash -ex

git add .
git commit -m "$1"
git push
hugo --minify
cd public && git add --all && git commit -m "Publishing to gh-pages" && git push origin gh-pages && cd ..