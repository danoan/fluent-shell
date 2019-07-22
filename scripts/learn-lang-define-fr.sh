#!/usr/bin/env bash
SCRIPT_FOLDER="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
source "$SCRIPT_FOLDER/learn-lang-globals.sh"

WORD=$1

wget --header="Accept: text/html" --user-agent="Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:66.0) Gecko/20100101 Firefox/66.0" "https://www.larousse.fr/dictionnaires/francais/$WORD" -O .larouse.temp --quiet

grep "<li class=\"DivisionDefinition\">.*</li>" .larouse.temp -o \
| sed "s/<[^>]*>//g" | sed "s/&[^;]*;//g" | head -n 5 | nl -w1

rm .larouse.temp
