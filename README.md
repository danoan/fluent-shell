# fluent-shell
Learn a language with the help of the shell.

## How it works

**Including a book**

```
>> ./learn-lang.py -a books/bel-ami.txt

Checking library files...
New book library initialized!
New word library initialized!
New book with id 1 included in the library!

```

**Learn a word**
```
>> ./learn-lang --word

Do you know this word?
   était
(P)ass (I)gnore (L)earn (G)ot it!
L

---Definitions for était---

1	Corps liquide à la température et à la pression ordinaires, incolore, inodore, insipide, dont les molécules sont 
composées d'un atome d'oxygène et de deux atomes d'hydrogène.
2	Ce corps liquide, contenant en solution ou en suspension toutes sortes d'autres corps (sels, gaz, micro-organismes, 
etc.), très répandu à la surface terrestre (eau de pluie, eau de mer, eau du robinet, etc.).
3	La mer, les rivières, les lacs, etc.: Aller au bord de l'eau.
4	Liquide organique ; sérosité: La cloque était pleine d'eau.
5	Bouillon de cuisson: Eau de riz.

---Examples---

1	 On était au 28 juin, et il lui restait juste en poche trois francs quarante pour finir le mois.
2	 Il était neuf heures un quart.
3	 Il était marié et journaliste, dans une belle situation.
4	 Il était bien changé, bien mûri.
```

*(P)ass*: Skip the word, but do not exclude from current learning list.

*(I)gnore*: Put the word in the ignored list. This word will never be displayed again.

*(L)earn*: Display definitions and examples

*(G)ot it*: Level up the stage learning of the word. There are three stages of learning.

Stage 1: Word may be choosen any time;

Stage 2: Word may be choosen after a week from its last appearance;

Stage 3: Word may be choosen after two weeks from its last appearance.

## Installation

Clone the repository and add the following line in your personal .bashrc file

```
export PATH=[PATH_TO_FLUENT_SHEEL_FOLDER]:$PATH
./learn-lang.py --word
```

