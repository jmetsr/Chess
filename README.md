# Chess
2 player Chess game for terminal written in Ruby
Before playing make sure you have ruby installed. 
Then in the command line, clone the repo and navigate to it.
Type "bundle install" into the command line. 
Then type "ruby game.rb" and the game will start
Play by typing in moves in the form "e2 e4" where e2 is the square you are moving from 
and e4 the square your piece is moving to.

- Game was implemented using object orientation principles by having a class for each piece type inherit from superclasses such as "stepping piece" and "sliding piece"
- Checkmate and check are checked for by performing the move on a dupped board
- Game is displayed using unicode chess piece characters
- All pieces contain a reference to the board they are on and their position on the board as instance variables
