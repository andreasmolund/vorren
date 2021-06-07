#!/usr/bin/env sh

# abort on errors
set -e

# build
npm run build

# navigate into the build output directory
cd dist

# if you are deploying to a custom domain
# echo 'www.example.com' > CNAME

git init
git add -A
git commit -m 'deploy'

git branch main

# if you are deploying to https://andreasmolund.github.io
git push -f git@github.com:andreasmolund/andreasmolund.github.io.git main

# if you are deploying to https://andreasmolund.github.io/vorren
#git push -f git@github.com:andreasmolund/vorren.git main:gh-pages

cd -