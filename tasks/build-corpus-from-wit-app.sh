#!/bin/sh
set -euv

curl -s -N "https://api.wit.ai/corpus" -H "Authorization: Bearer $WIT_TOKEN"\
| jq '[.[] | sub("^@\\w* ?";"")]|unique' \
> ./data/corpus-wit.json
echo $(jq '.|length' data/corpus-wit.json) statements
