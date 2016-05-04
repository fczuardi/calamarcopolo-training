#!/bin/sh
set -eu

cat "$1" \
| jq "[.utterances[] | select(.intent == \"get_trip\").text]" \
> ./data/corpus-luis-get_trip.json
