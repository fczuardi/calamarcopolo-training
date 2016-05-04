#!/bin/sh
set -euv

cat "$1" \
| jq '[.items[].place.name|sub("\\,..."; "")|sub(".\\-.*"; "")][0:1030]|unique' \
> ./data/entities-places.json
