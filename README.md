# odin-ruby-hangman

Recreating the game Hangman in Ruby, as part of web development course [The Odin Project](https://www.theodinproject.com/)

---

### How to Play
From a terminal, navigate to the folder and run `ruby main.rb`\
Load a saved game by entering `y` or start new game by entering any other character\
You have 8 guesses before game over\
Once a game has been started, save at any time by entering `save`\
__NB:__ saving a game will overwrite any existing game.

---

### Basic skills showcased
- File I/O
- Serialisation using YAML
- Input validation
- Basic encoding, so word cannot be easily determined from reading the saved_game.yaml file

---

```
Save game found! Enter 'y' to load saved game, or anything else to load new game.
y
Game imported successfully!
_ _ _ t _ e a _ t 
Incorrect letters: r
Guess a letter, or type 'save' to quit: 
s
s _ _ t _ e a s t 
Incorrect letters: r
Guess a letter, or type 'save' to quit: 
o
s o _ t _ e a s t 
Incorrect letters: r
Guess a letter, or type 'save' to quit: 
h
s o _ t h e a s t 
Incorrect letters: r
Guess a letter, or type 'save' to quit: 
u
s o u t h e a s t 
Incorrect letters: r
Congratulations, you won!
```