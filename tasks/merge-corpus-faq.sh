#!/bin/sh
set -euv

jq -s '[.[0][], .[1][], .[2][], .[3][], .[4][], .[5][], .[6][], .[7][], .[8][], .[9][], .[10][], .[11][]]|unique' \
./data/corpus-luis-faq_crianca.json \
./data/corpus-luis-faq_deficiente.json \
./data/corpus-luis-faq_escolherassento.json \
./data/corpus-luis-faq_estudante.json \
./data/corpus-luis-faq_idoso.json \
./data/corpus-luis-faq_levaranimais.json \
./data/corpus-luis-faq_limitepeso.json \
./data/corpus-luis-faq_menordeidade.json \
./data/corpus-luis-faq_passagem.json \
./data/corpus-luis-faq_seguro.json \
./data/corpus-luis-faq_viagemlatam.json \
./data/corpus-luis-faq_voucher.json \
> ./data/corpus-luis-faq.json
echo $(jq '.|length' data/corpus-luis-faq.json) statements

jq '.[]' data/corpus-luis-faq.json
