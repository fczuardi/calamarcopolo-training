#!/bin/sh
set -euv

mkdir -p ./data
curl -s -N "https://api.wit.ai/corpus" -H "Authorization: Bearer $WIT_TOKEN"\
| jq 'unique' \
> ./data/corpus.json
echo $(jq '.|length' data/corpus.json) utterances
