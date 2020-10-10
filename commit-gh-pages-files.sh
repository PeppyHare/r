#!/bin/bash -ex

hugo --minify
cd public && git add --all && git commit -m "Publishing to gh-pages" && git push origin gh-pages && cd ..