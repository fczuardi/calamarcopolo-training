#!/bin/sh
set -euv

entityName=$1
valuesFile=$2

function addEntityValue {
    entityValue=$1
    curl -XPOST "https://api.wit.ai/entities/$entityName/values" \
    -H "Authorization: Bearer $WIT_TOKEN" \
    -H 'Content-Type: application/json' \
    -d '{ "value":"'"$entityValue"'" }' \
    --connect-timeout 30 --retry 3 --retry-delay 5
}

# change IFS so for loops don't separate use spaces as separators
IFS=$'\n'
for value in $(jq -r '.[]' "$valuesFile"); do
    echo "addEntityValue $value"
    addEntityValue "$value"
    # break
done
