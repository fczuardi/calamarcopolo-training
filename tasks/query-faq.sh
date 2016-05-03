#!/bin/sh
set -euv

jq -r '.[]|@uri' data/corpus-luis-faq.json \
> data/corpus-wit-query-urls.txt

url="https://api.wit.ai/message/?q="
for i in $(cat data/corpus-wit-query-urls.txt); do
    curl -H "Authorization: Bearer $WIT_TOKEN" \
    "https://api.wit.ai/message?v=20141022&q=$i"\
    >> output.txt
done
