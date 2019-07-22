#!/usr/bin/python3

import argparse
import subprocess,os

PROJECT_FOLDER=os.path.dirname(os.path.abspath(__file__))

def read_input():
    parser = argparse.ArgumentParser(description="Language learning tool for the terminal")

    parser.add_argument("-a","--add",dest="add",action="store",nargs=1,type=str,
    help="path to the text file")

    parser.add_argument("-w","--word",dest="word",action="store_true",help="a word from current learning library will be chosen for display")

    args = parser.parse_args()
    return {"add":None if args.add is None else args.add[0],
    "word":args.word}

def add_text_file(filepath):
    create_dict_script="%s/scripts/create-dict.py" % (PROJECT_FOLDER,)
    add_book_script="%s/scripts/learn-lang-add.sh" % (PROJECT_FOLDER,)

    temp_frequency_file="%s/.temp_frequency_file" % (PROJECT_FOLDER,)

    subprocess.call( [create_dict_script,
                      filepath,
                      temp_frequency_file] )
    subprocess.call( [add_book_script,
                      temp_frequency_file])

    os.remove(temp_frequency_file)

def select_word():
    word_of_day_script_script="%s/scripts/learn-lang-word-day.sh" % (PROJECT_FOLDER,)
    subprocess.call( [word_of_day_script_script,] )

def main():
    id = read_input()
    if id["add"] is not None:
        add_text_file(id["add"])
    elif id["word"] is not False:
        select_word()
    else:
        print("No action done!")

    return 0

if __name__=='__main__':
    main()
