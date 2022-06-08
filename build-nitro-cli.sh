#!/bin/bash
set -ex

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
TMP_DIR=$(mktemp -d -t 'nitro')
NITRO_SOURCE_DIR="$SCRIPT_DIR/node_modules/underscope-ci"
NITRO_SOURCE_TMP_DIR="$TMP_DIR/underscope-ci"

cp -R "$NITRO_SOURCE_DIR" "$TMP_DIR"

cd "$NITRO_SOURCE_TMP_DIR"
yarn

NITRO_BUILDER_TMP_DIR="$NITRO_SOURCE_TMP_DIR/packages/builder"
cd "$NITRO_BUILDER_TMP_DIR"
yarn dist

cd "$SCRIPT_DIR"
rm -rf "$SCRIPT_DIR/dist"
cp -R "$NITRO_BUILDER_TMP_DIR/dist" "$SCRIPT_DIR"
