#!/bin/sh
set -euv

cat "$1" \
| jq [.utterances[].text] \
> ./data/corpus-luis.json
echo $(jq '.|length' data/corpus-luis.json) statements
