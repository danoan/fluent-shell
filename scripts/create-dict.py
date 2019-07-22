#!/usr/bin/python3

import argparse
import operator
import os

import time

BUFFER_SIZE=1000
SKIP_SIZE=100

APOSTROPHE_DICT={"l":"le","d":"de","j":"je","n":"ne","m":"me","c":"ce","s":"se","t":"tu","qu":"que"}
USEFUL_CHARS=["a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","x","w","y","z","é","è","ù","à","â","ê","î","ô","û","ç"]
PONCTUATION=[",",";",":",".","..."]

def msg(t,verbose):
    if verbose:
        print(t)

def read(filepath):
    with open(filepath) as f:
        b = "".join(f.readlines(BUFFER_SIZE))
        while len(b)!=0:
            lines=0
            for c in b:
                if c=='\n':
                    lines+=1
            words=len( b.split(" ") )

            yield {"extract":b,"words":words,"lines":lines}
            b = "".join(f.readlines(BUFFER_SIZE))

def count_lines_words(filepath):
    lines=0;
    words=0
    for ext in read(filepath):
        lines+=ext["lines"]
        words+=ext["words"]

    return lines,words

def apostrophe(w):
    if "'" in w or "`" in w or "’" in w:
        return True

    return False

def clean_word(word):
    word=word.lower()
    while len(word)>0 and word[0] not in USEFUL_CHARS:
        word=word[1:]

    while len(word)>0 and word[-1] not in USEFUL_CHARS:
        word=word[0:-1]

    return word

def remove_ponctuation(filepath,temp_filepath):
    with open(temp_filepath,"w") as t:
        with open(filepath) as f:
            b = " "
            while len(b)!=0:
                b = "".join(f.readlines(BUFFER_SIZE))
                for p in PONCTUATION:
                    b = b.replace(p," ")
                t.write(b)


def update_dict(d,ext):
    for word in ext["extract"].split(" "):
        word = clean_word(word)
        if(len(word)==0):
            continue

        if apostrophe(word):
	           continue

        if word in d:
            d[word]+=1
        else:
            d[word]=1

def create_dict_words(filepath,verbose):
    curr_line=0
    skip=0
    d={}
    for ext in read(filepath):
        curr_line+=ext['lines']
        update_dict(d,ext)
        if skip%SKIP_SIZE==0:
            msg("\t%d lines analysed..." % (curr_line,),verbose )
        skip+=1

    return d

def write_dictionnaire(d,book_filepath,ignore,out_filepath,verbose):
    sorted_items=sorted(d.items(),key=operator.itemgetter(1),reverse=True)

    with open(out_filepath,'w') as f:
        f.write("#Original file: %s\n#Unique words: %d\n" % (book_filepath,len(d)))
        for key,value in sorted_items:
            if value < ignore:
                f.write("%s %d\n" % (key,value))

    msg("Dictionnaire written succesffuly at: %s" % (out_filepath,),verbose)

def analyse_book(filepath,verbose):
    msg("Reading Book: %s" % (filepath,),verbose)
    temp_filepath=".temp"
    remove_ponctuation(filepath,temp_filepath)
    lines,words = count_lines_words(temp_filepath)

    msg("\tThe book has %d lines and %d words" % (lines,words),verbose)
    d=create_dict_words(temp_filepath,verbose)

    msg("The book has %d unique words!" % (len(d), ),verbose )
    os.remove(temp_filepath)
    return d

def read_input():
    parser = argparse.ArgumentParser(description='Create word dictionnaire from a text file.')

    parser.add_argument('book', action='store', type=str, nargs=1,
                       help='path of the book to be anlysed')
    parser.add_argument('dict_out', action='store', type=str, nargs=1,
                       help='dictionnaire output path')
    parser.add_argument('-i','--ignore', dest="ignore", action='store', type=int, nargs=1, default=[500],
                       help='words occurences greater than indicated will be ignored')
    parser.add_argument('-v','--verbose',dest="verbose", action='store_true',
                   help='print messages along the process')


    args = parser.parse_args()
    id = {"book_file_path":args.book[0],
    "dict_out_path":args.dict_out[0],
    "ignore": None if args.ignore is None else args.ignore[0],
    "verbose":args.verbose}

    return id

def main():
    id = read_input()

    d = analyse_book(id["book_file_path"],id["verbose"])
    write_dictionnaire(d,id["book_file_path"],id["ignore"],id["dict_out_path"],id["verbose"])


if __name__=='__main__':
    main()
