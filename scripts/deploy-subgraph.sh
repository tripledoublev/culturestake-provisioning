#!/bin/bash

source "scripts/common.sh"

REPOSITORY=https://github.com/tripledoublev/culturestake-subgraph.git
FOLDER_NAME=subgraph

check_tmp_folder $REPOSITORY $FOLDER_NAME

# Clean up
rm -rf build src/types

# Use this for local testing:
#git checkout 123457

git fetch --all
git reset --hard origin/main

# Install dependencies
echo "Installing npm dependencies .."
npm install &> /dev/null

# Link to .env file
ln -f -s ../../.env .env

# Prepare subgraph
npm run codegen
npm run build

# Create and deploy subgraph to node
npm run create
npm run deploy
