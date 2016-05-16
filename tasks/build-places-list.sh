#!/bin/sh
set -euv

cat "$1" \
| jq '[.items[]|(.place.name|sub(".\\-.*"; ""))+"|"+.slug+"|"+(.place.name|sub("\\,..."; "")|sub(".\\-.*"; ""))+"|"+(.place.name|sub("\\,..."; "")|sub(".\\-.*"; "")|ascii_downcase)][0:1030]|sort' \
> ./data/entities-places.json
