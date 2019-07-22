#!/usr/bin/env bash

SCRIPT_FOLDER="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
source "$SCRIPT_FOLDER/learn-lang-globals.sh"
source "$SCRIPT_FOLDER/learn-lang-utils.sh"

function full()
{
  N=$(word_candidates | wc -w)
  if [ "$N" -le "5" ]
  then
    echo ""
  else
    echo "NOT EMPTY"
  fi
}

function select_new_words_to_learn()
{
  newWords=$(head $LLG_WORD_LIBRARY -n 11 | tail -n 10) #| cut -d" " -f1
  echo "$newWords" | xargs -I{} echo "{} 1 $LLG_TODAY" >> $LLG_LEARNING_LIBRARY
  echo "$newWords" | xargs -I{} bash -c 'remove_word "{}" $LLG_WORD_LIBRARY'
}

function word_candidates()
{
	tempFile=.temp
	echo " " > $tempFile
	
	tail -n +2 $LLG_LEARNING_LIBRARY | cut -d" " -f4 | xargs -I{} bash -c \
	'if [ "{}" -le "$LLG_TODAY" ] ; then echo "True" ; else echo "False"; fi'>> $tempFile

	paste $LLG_LEARNING_LIBRARY $tempFile -d" " | nl -w1 -s" " -v1 \
	| grep "True$" | cut -d" " -f1 \
	| tr "\n" " "

 	rm $tempFile
}

function new_check_date()
{
   stage=$1
   if [ $stage = 1 ]
   then
	echo $LLG_TODAY
   elif [ $stage = 2 ]
   then
	echo $(date -d "+7 days" +%s)
   elif [ $stage = 3 ]
   then
	echo $(date -d "+14 days" +%s)
   else
	echo $(date -d "+30 days" +%s)
   fi
}

function update_date()
{
   lineNumber=$1

   lineData=$(get_line $LLG_LEARNING_LIBRARY $lineNumber)
   stage=$( echo $lineData | cut -d" " -f3 )

   newData=$(echo $lineData | cut -d " " -f4 --complement)
   newDate=$(new_check_date $stage)
   echo "$newData $newDate" >> $LLG_LEARNING_LIBRARY
}

function pick_word()
{
    cand=$(word_candidates)
    ncand=$(echo $cand | wc -w)

    N=$(( $RANDOM % $ncand ))
    N_1=$(( $N + 1 ))
    selected=$(echo $cand | cut -d" " -f$N_1)

    update_date $selected
    word=$(get_line $LLG_LEARNING_LIBRARY $selected | cut -d" " -f1)

    delete_line $LLG_LEARNING_LIBRARY $selected
    echo "$word"
}

function add_ignore()
{
  MOT=$1
  echo $1 >> $LLG_IGNORED_LIBRARY
}

function remove_learning()
{
  grep -vw "^$1 [^d] [^d]" $LLG_LEARNING_LIBRARY > .temp
  mv .temp $LLG_LEARNING_LIBRARY
}

function remove_word()
{
  WORD=$1
  WL=$2

  grep -vw "^$WORD" $WL > .temp
  mv .temp $WL
}

function improve_stage()
{
   word=$1
   register=$(grep -w "$word [^d] [^d]" $LLG_LEARNING_LIBRARY)

   word_name=$(echo $register | cut -d" " -f1)
   word_bid=$(echo $register | cut -d" " -f2)
   word_stage=$(echo $register | cut -d" " -f3)
   word_stage=$(( $word_stage + 1 ))
   word_date=$(new_check_date $word_stage)

   remove_learning $word
   if [ $word_stage -le 3 ]
   then
      echo "$word_name $word_bid $word_stage $word_date" >> $LLG_LEARNING_LIBRARY
   else
      add_learned $word
   fi
   
}

function add_learned()
{
  WORD=$1
  echo $WORD >> $LLG_LEARNED_LIBRARY
  remove_learning $WORD
}

function lang_define()
{
  clear
  echo "---Definitions for $1---" && echo
  bash -c "${SCRIPT_FOLDER}/learn-lang-define.sh $1" && echo
  echo "---Examples---" && echo
  bash -c "${SCRIPT_FOLDER}/learn-lang-context.sh $1"
}

function word_of_day()
{
  check_files

  if [ -z $(full) ]
  then
    select_new_words_to_learn
  fi

  clear

  WORD=$(pick_word)
  echo "Do you know this word?"
  echo "   $WORD"
  read -p "(P)ass (I)gnore (L)earn (G)ot it!" -n 1 action

  if [ "$action" == "p" ]
  then
    word_of_day
  elif [ "$action" == "i" ]
  then
    add_ignore $WORD
    remove_learning $WORD
    word_of_day
  elif [ "$action" == "l" ]
  then
    lang_define $WORD
  elif [ "$action" == "g" ]
  then
    improve_stage $WORD
    word_of_day
  else
    echo "Unknown command"
  fi
}

export -f remove_word

word_of_day
