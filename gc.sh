#!/bin/bash -ex

git add .
# git reset layouts/partials/docs/inject/content-after.html
git commit -m "$1"
git push
hugo -v
cd public && git add --all && git commit -m "Publishing to gh-pages" && git push origin gh-pages && cd ..