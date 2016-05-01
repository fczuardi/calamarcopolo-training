#!/bin/sh
set -euv

jq -s '[.[0][], .[1][]]|unique' data/corpus-wit.json data/corpus-luis.json \
> ./data/corpus.json
echo $(jq '.|length' data/corpus.json) statements
