#!/bin/sh
set -e

GIT_DEPLOY_REPO="${GIT_DEPLOY_REPO:-"$(node -e 'process.stdout.write(require("./package.json").repository)')"}"

if [ "$TRAVIS" = "true" ]
then
  # git need this, on Travis-CI nobody is defined
  git config --global user.name "fydy" && \
  git config --global user.email "edu@yuns.me"
fi

cd out
rm -rf .git static
cp -rL ../static .
touch .nojekyll
echo 'luolvshi.me/nextjs' > CNAME

git init
git add .
git commit -m "Deploy to GitHub Pages"

env:
  global:
	- GIT_DEPLOY_REPO=https://$nextjs@github.com/fydy/nextjs.git
