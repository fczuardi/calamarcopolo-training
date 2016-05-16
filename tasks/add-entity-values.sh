#!/bin/sh
set -euv

entityName=$1
valuesFile=$2

function addEntityValue {
    inputString=$1
    IFS='|' read -ra PARTS <<< "$inputString"
    entityValue="${PARTS[0]}"
    slug="${PARTS[1]}"
    alias1="${PARTS[2]}"
    alias2="${PARTS[3]}"
    echo "${PARTS[@]}"
    curl -XPOST "https://api.wit.ai/entities/$entityName/values?v=20160516" \
    -H "Authorization: Bearer $WIT_TOKEN" \
    -H 'Content-Type: application/json' \
    -d '{
        "value":"'"$entityValue"'",
        "expressions": ["'"$alias1"'", "'"$alias2"'"],
        "metadata": "{\"slugs\": [\"'"$slug"'\"]}"}' \
    --connect-timeout 30 --retry 3 --retry-delay 5
}


function deleteEntityValue {
    inputString=$1
    IFS='|' read -ra PARTS <<< "$inputString"
    entityValue="${PARTS[2]}"
    echo "https://api.wit.ai/entities/$entityName/values/$entityValue?v=20160516"
    curl -XDELETE "https://api.wit.ai/entities/$entityName/values/$entityValue?v=20160516" \
    -H "Authorization: Bearer $WIT_TOKEN" \
    --connect-timeout 30 --retry 3 --retry-delay 5
}

# change IFS so for loops don't separate use spaces as separators
IFS=$'\n'
for value in $(jq -r '.[]' "$valuesFile"); do
    echo "addEntityValue $value"
    addEntityValue "$value"
    # echo "deleteEntityValue $value"
    # deleteEntityValue "$value"
    # break
done
