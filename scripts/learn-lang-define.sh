#!/usr/bin/env bash
SCRIPT_FOLDER="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
source "$SCRIPT_FOLDER/learn-lang-globals.sh"

$SCRIPT_FOLDER/learn-lang-define-fr.sh $1
