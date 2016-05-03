#!/bin/sh
set -eu

# A directory containing intents subdirectories
intentsDir=$1

# Global var to store the id of the last created intent-entity
createdEntityID=""

function createEntity {
    # debugSufix="_Q"
    # entityName="$1$debugSufix"
    entityName="$1"

    creationPayload='{
        "doc":"'"$entityName"'",
        "id":"'"$entityName"'",
        "values":[]
    }'
    echo "creationPayload $creationPayload"

    createdEntityID=$(curl -XPOST 'https://api.wit.ai/entities' \
    -H "Authorization: Bearer $WIT_TOKEN" \
    -H "Content-Type: application/json" \
    -d "$creationPayload" | jq -r '.id'
    )
    echo "createdEntityID $createdEntityID"
}

function addExpressionToTraitValue {
    echo "addExpressionToTraitValue $1, $2"
    curl 'https://api.wit.ai/sync' -X PUT \
    -H "Authorization: Bearer $WIT_BROWSER_TOKEN" \
    -H 'Content-Type: application/json' \
    -H "X-Wit-Instance: $WIT_APP_ID" \
    --data-binary '[{
        "data":{
            "text":{
                "text":"'"$2"'"
            },
            "semantic":{
                "intent":"'"$INTENTID"'",
                "entities":[
                    {
                        "value":"'"$1"'",
                        "start":null,
                        "end":null,
                        "wisp":"'"$createdEntityID"'"
                    }
                ]
            }
        },
        "type":"added-semantic"
    }]' --compressed
}

# change IFS so for loops don't separate use spaces as separators
IFS=$'\n'

for intentFolderName in $(ls "$intentsDir"); do
    createEntity "$intentFolderName"
    intentPath="$intentsDir/$intentFolderName";
    for expressionsFileName in $(ls "$intentPath"); do
        traitValue=$(basename "$expressionsFileName" .json)
        expressionsFile="$intentPath/$expressionsFileName";
        for query in $(jq -r '.[]' "$expressionsFile"); do
            addExpressionToTraitValue "$traitValue" "$query"
            # debug, just the first string
            # break
        done
        # debug, just the first file
        # break
    done
done
