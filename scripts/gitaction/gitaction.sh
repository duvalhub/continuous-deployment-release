#!/bin/bash

pwd
ls -l
git remote -v

NEW_BRANCH="release/1.2.3"
git checkout -b $NEW_BRANCH
git push origin $NEW_BRANCH