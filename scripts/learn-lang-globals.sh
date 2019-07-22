export LLG_PROJECT_FOLDER="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
export LLG_BOOKS_FOLDER="$LLG_PROJECT_FOLDER/books"
export LLG_BOOK_LIBRARY="$LLG_PROJECT_FOLDER/.book_library"
export LLG_WORD_LIBRARY="$LLG_PROJECT_FOLDER/.word_library"
export LLG_IGNORED_LIBRARY="$LLG_PROJECT_FOLDER/.ignored_words"
export LLG_LEARNING_LIBRARY="$LLG_PROJECT_FOLDER/.learning"
export LLG_LEARNED_LIBRARY="$LLG_PROJECT_FOLDER/.learned"
export LLG_TODAY=$(date +%s)

function check_book_library()
{
  echo "Checking library files..."
  if [ -e "$LLG_BOOK_LIBRARY" ]
  then
    echo "$(cat $LLG_BOOK_LIBRARY | tail -n +1 | wc -l) books in the libray"
  else
    echo "# BOOK_ID BOOK_PATH" > $LLG_BOOK_LIBRARY
    echo "New book library initialized!"
  fi
}

function check_word_library()
{
  if [ -e "$LLG_WORD_LIBRARY" ]
  then
    TO_LEARN=$(cat $LLG_WORD_LIBRARY | tail -n +1 | cut -d" " -f2 | grep "F" | wc -l)
    echo "$TO_LEARN words to learn yet"
  else
    echo "# WORD BOOK_ID" > $LLG_WORD_LIBRARY
    echo "New word library initialized!"
  fi
}

function check_ignored_library()
{
  if [ -e "$LLG_IGNORED_LIBRARY" ]
  then
    echo "$(cat $LLG_IGNORED_LIBRARY | wc -l) in the ignored list!"
  else
    touch $LLG_IGNORED_LIBRARY
  fi
}

function check_learning_library()
{
  if ! [ -e $LLG_LEARNING_LIBRARY ]
  then
    echo "# WORD STAGE BID NEXT_CHECK" > $LLG_LEARNING_LIBRARY
  fi
}

function check_learned_library()
{
  if ! [ -e $LLG_LEARNED_LIBRARY ]
  then
    touch $LLG_LEARNED_LIBRARY
  fi
}

function check_files()
{
  check_book_library
  check_word_library
  check_ignored_library
  check_learned_library
  check_learning_library

  if ! [ -d "$LLG_BOOKS_FOLDER" ]
  then
    mkdir $LLG_BOOKS_FOLDER
  fi

}
