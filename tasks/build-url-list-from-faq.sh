#!/bin/sh
set -euv

cat "$1" \
| jq "[.utterances[] | select(.intent == \"faq_deficiente\").text]" \
> ./data/corpus-luis-faq_deficiente.json

cat "$1" \
| jq "[.utterances[] | select(.intent == \"faq_passagem\").text]" \
> ./data/corpus-luis-faq_passagem.json

cat "$1" \
| jq "[.utterances[] | select(.intent == \"faq_levaranimais\").text]" \
> ./data/corpus-luis-faq_levaranimais.json

cat "$1" \
| jq "[.utterances[] | select(.intent == \"faq_limitepeso\").text]" \
> ./data/corpus-luis-faq_limitepeso.json

cat "$1" \
| jq "[.utterances[] | select(.intent == \"faq_idoso\").text]" \
> ./data/corpus-luis-faq_idoso.json

cat "$1" \
| jq "[.utterances[] | select(.intent == \"faq_viagemlatam\").text]" \
> ./data/corpus-luis-faq_viagemlatam.json

cat "$1" \
| jq "[.utterances[] | select(.intent == \"faq_voucher\").text]" \
> ./data/corpus-luis-faq_voucher.json

cat "$1" \
| jq "[.utterances[] | select(.intent == \"faq_estudante\").text]" \
> ./data/corpus-luis-faq_estudante.json

cat "$1" \
| jq "[.utterances[] | select(.intent == \"faq_menordeidade\").text]" \
> ./data/corpus-luis-faq_menordeidade.json

cat "$1" \
| jq "[.utterances[] | select(.intent == \"faq_seguro\").text]" \
> ./data/corpus-luis-faq_seguro.json

cat "$1" \
| jq "[.utterances[] | select(.intent == \"faq_crianca\").text]" \
> ./data/corpus-luis-faq_crianca.json

cat "$1" \
| jq "[.utterances[] | select(.intent == \"faq_escolherassento\").text]" \
> ./data/corpus-luis-faq_escolherassento.json
