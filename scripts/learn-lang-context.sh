#!/usr/bin/env bash
SCRIPT_FOLDER="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
source "$SCRIPT_FOLDER/learn-lang-globals.sh"

function book_id()
{
  MOT=$1
  echo $(grep "^$MOT" $LLG_LEARNING_LIBRARY | head -n 1 | cut -d" " -f2)
}

MOT="$1"
BID=$(book_id $MOT)
BOOK_PATH=$(grep "^$BID " $LLG_BOOK_LIBRARY | cut -d" " -f2)

egrep -o "[^\.\?\!]*. $MOT[\.,:;]? [^\.\?\!]*." $BOOK_PATH | nl -w1 | head -n 4
