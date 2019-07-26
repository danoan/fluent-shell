<img src="logo.png" width="320px" />

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
   toujours
(P)ass (I)gnore (L)earn (G)ot it!
L

---Definitions for toujours---

1	la permanence dans la totalité du temps ou d'une période déterminée: Ces abus ont toujours existé.
2	la répétition constante d'un fait, d'une situation: Quand il vient à Paris, il passe toujours me voir.
3	la continuation, la persistance d'un état du passé jusqu'au moment présent ou au moment considéré (la négation pas se place après l'adverbe): Je ne suis toujours pas satisfait.
4	une possibilité souvent très incertaine dans l'avenir (surtout après pouvoir ou après un impératif): Viens toujours, on verra bien.
5	S'emploie comme intensif: C'est toujours mieux que rien.

---Examples---

1	Les femmes avaient levé la tête vers lui, trois petites ouvrières, une maîtresse de musique entre deux âges, mal peignée, négligée, coiffée d’un chapeau toujours poussiéreux et vêtue toujours d’une robe de travers, et deux bourgeoises avec leurs maris, habituées de cette gargote à prix fixe.
2	 Il avait l’air de toujours défier quelqu’un, les passants, les maisons, la ville entière, par chic de beau soldat tombé dans le civil.
3	 Quelquefois cependant, grâce à sa belle mine et à sa tournure galante, il volait, par-ci, par-là, un peu d’amour, mais il espérait toujours plus et mieux.
4	La foule glissait autour de lui, exténuée et lente, et il pensait toujours : « Tas de brutes !
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

