#!/usr/bin/env bash
SCRIPT_FOLDER="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
source "$SCRIPT_FOLDER/learn-lang-globals.sh"

function add_mot()
{
  NUM_LINE=$1
  MOT=$2
  TOTAL_LINE=$3
  BOOK_ID=$4
  WORD_LIBRARY=$5
  IGNORED_LIBRARY=$6

  I=$(grep -w "^$MOT" $IGNORED_LIBRARY | wc -l)
  if [ "$I" == "0" ]
  then
    echo "$MOT $BOOK_ID" >> $WORD_LIBRARY
  fi

  if [ $(( $NUM_LINE % 500 )) == "0" ]
  then
    echo "$NUM_LINE/$TOTAL_LINE"
  fi
}

function add_book()
{
  BOOK_ORIGINAL_PATH=$(realpath $1)
  BOOK_NAME=$(basename $BOOK_ORIGINAL_PATH)
  BOOK_PATH="${BOOKS_FOLDER}/${BOOK_NAME}"

  echo "$BOOK_ORIGINAL_PATH ::: $BOOK_PATH"
  cp $BOOK_ORIGINAL_PATH $BOOK_PATH

  BOOK_IN_LIBRARY=$(grep $BOOK_NAME $BOOK_LIBRARY)
  if [ -z "$BOOK_IN_LIBRARY" ]
  then
      ID=$(get_last_id)
      ID=$(( $ID + 1 ))
      echo "$ID $BOOK_PATH" >> $BOOK_LIBRARY
      echo "New book with id $ID included in the library!"
  else
    echo "Book alread in the library!"
    exit
  fi
}

function get_last_id()
{
  ID=$(tail -1 $BOOK_LIBRARY | cut -d" " -f1)
  if [ $ID == "#" ]
  then
    ID="0"
  fi
  echo "$ID"
}

function add_from_frequency_file()
{
  FF=$1
  NUM_WORDS=$(head $FF -n 2 | tail -n 1 | cut -d" " -f3)
  BOOK_PATH=$(head $FF -n 1 | cut -d" " -f3)
  add_book $BOOK_PATH
  BOOK_ID=$(get_last_id)
  tail $FF -n +3 | nl -w1 -s" " | cut -d" " -f 1,2 | xargs -I{} bash -c "add_mot {} $NUM_WORDS $BOOK_ID $WORD_LIBRARY $IGNORED_LIBRARY"
}

export -f add_mot
check_files
add_from_frequency_file $1
