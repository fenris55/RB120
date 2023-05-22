=begin
# Notes for Lesson 2 Walk Paper Scissors planning and walkthrough

OOP approach:
-write textual description of problem
-extract nouns and verbs
-organize and assocaite nouns and verbs
-create classes with nouns and methods/behaviors with verbs

My textual writeup:
rock paper scissors is a 2-player game. Both plays can chose from rock, paper,
or scissors. To play a single round, each player makes a choice. The choices are
comapred and the winner is determined. If players make the same choice, the
result is a tie

Rules for determining winner/comparing choices are:
-rock beats scissors
-scissors beat paper
-paper beats rock

Three possible outcomes: player1 wins, player2 wins, tie

Extracted nouns and verbs:
nouns: player1, player2, choice, tie # LS uses: player, move, rule
verbs: choose, compare, announce/display # LS uses: choose, compare

LS noun/verb grouping:
Player #class
  choose #method/behavior
Move #class -> or module?
  -thoughts:
  -contain method for prompting a move - should prompt player to choose rp or s
    and validate that choice (since computer is not a real player, somewhere
    we need to override a move method to perform random selection and assign to
    computer's choice)
Rule #class
  -should take inputs/choices from both players, pass into compare method, and
  make a ruling on the winner

-compare #method/behavior

Example class outlines based on notes:
class RPSGame
#"engine" class -> procedural code will happen here ("main" game class)

  attr_accessor :human, :computer

  def initialize #upon instantiation of a game/RPSGame instance, we need 2
  player class instances to be created
    @human = Player.new
    @computer = Player.new
  end

  def play
    #class method? this is how a new game will be started -> need to invoke
    methods from here
    #possible methods:
    display_welcome_message
    human.choose
    computer.choose
    display_winner
    display_goodbye_message
  end
end

class Player
  def initialize
    #save player name?
  end
end

class Move
  def initialize
   # -need to capture the move each player makes and save
  end
end

class Rule
  def initiliaze
  #is this necessary? what would a Rule object be? winner and loser? initialize
  to the compare return values?
  end
end

def compare(move1, move2)
  #compare is being being defined as a method that doesn't belong anywhere yet
end

### Video walk-through version: not refactored
class Player
  attr_accessor :move, :name

  def initialize(player_type=:human)
    @player_type = player_type #example of state - state of player can be human
    or computer
    @move = nil #keeping track of the state of a player's move; will be accessed
    by/passed to display winner method
    set_name
  end

  def set_name
     if human?
       n = ''
        loop do
          puts "What's your name?"
          n = gets.chomp.capitalize
          break unless n.empty?
          puts "Please enter a valid name"
        end
        self.name = n
    else
      self.name = %w(R2D2 C3PO Walle).sample
    end
  end

  def choose
    if human? #invoking a method
      choice = nil
      loop do
        puts "Please choose rock, paper, or scissors:"
        choice = gets.chomp.downcase
        break if %w(rock paper scissors).include?(choice)
        puts "Sorry, that's not a valid choice."
      end
      self.move = choice
    else
      self.move = %w(rock paper scissors).sample
    end
  end

  def human?
    @player_type == :human
  end
end

class RPSGame
  attr_accessor :human, :computer

  def initialize
    @human = Player.new
    @computer = Player.new(:computer)
  end

  def display_welcome_message
    puts "Welcome to Rock Paper Scissors!"
  end

  def display_winner
    puts "#{human.name} chose #{human.move}."
    puts "#{computer.name} chose #{computer.move}."
    puts "-----------------------------------------"
    case human.move
    when "rock"
      puts "It's a tie!" if computer.move == "rock"
      puts "#{human.name} won!" if computer.move == "scissors"
      puts "#{computer.name} won!" if computer.move == "paper"
    when "paper"
      puts "It's a tie!" if computer.move == "paper"
      puts "#{human.name} won!" if computer.move == "rock"
      puts "#{computer.name} won!" if computer.move == "scissors"
    when "scissors"
      puts "It's a tie!" if computer.move == "scissors"
      puts "#{human.name} won!" if computer.move == "paper"
      puts "#{computer.name} won!" if computer.move == "rock"
    end
  end

  def play_again?
    answer = nil
    loop do
      puts "Would you like to play again? (y/n)"
      answer = gets.chomp.downcase
      break if %w(y n).include?(answer)
      puts "Please type y or n."
    end
    answer == 'y' ? true : false
  end

  def display_goodbye_message
    puts "Thanks for playing! Goodbye!"
  end

  def play
    display_welcome_message
    loop do
      human.choose
      computer.choose
      display_winner
      break unless play_again?
    end
    display_goodbye_message
  end
end

RPSGame.new.play

=end

# refactored with video:
class Move
  VALUES = %w(rock paper scissors)

  def initialize(value)
    @value = value
  end

  def scissors?
    @value == 'scissors'
  end

  def rock?
    @value == 'rock'
  end

  def paper?
    @value == 'paper'
  end

  def >(other_move)
    return other_move.scissors? if rock?
    return other_move.rock? if paper?
    return other_move.paper? if scissors?
  end

  def <(other_move)
    return other_move.paper? if rock?
    return other_move.scissors? if paper?
    return other_move.rock? if scissors?
  end

  def to_s
    @value
  end
end

class Player
  attr_accessor :move, :name

  def initialize
    set_name
  end
end

class Human < Player
  def set_name
    n = ''
    loop do
      puts "What's your name?"
      n = gets.chomp.capitalize
      break unless n.empty?
      puts "Please enter a valid name"
    end
    self.name = n
  end

  def choose
    choice = nil
    loop do
      puts "Please choose rock, paper, or scissors:"
      choice = gets.chomp.downcase
      break if Move::VALUES.include?(choice)
      puts "Sorry, that's not a valid choice."
    end
    self.move = Move.new(choice)
  end
end

class Computer < Player
  def set_name
    self.name = %w(R2D2 C3PO Walle).sample
  end

  def choose
    self.move = Move.new(Move::VALUES.sample)
  end
end

class RPSGame
  attr_accessor :human, :computer

  def initialize
    @human = Human.new
    @computer = Computer.new
  end

  def display_welcome_message
    puts "Welcome to Rock Paper Scissors!"
  end

  def display_moves
    puts "-----------------------------------------"
    puts "#{human.name} chose #{human.move}."
    puts "#{computer.name} chose #{computer.move}."
    puts "-----------------------------------------"
  end

  def display_winner
    if human.move > computer.move
      puts "#{human.name} won!"
    elsif human.move < computer.move
      puts "#{computer.name} won!"
    else
      puts "It's a tie!"
    end
  end

  def play_again?
    answer = nil
    loop do
      puts "Would you like to play again? (y/n)"
      answer = gets.chomp.downcase
      break if %w(y n).include?(answer)
      puts "Please type y or n."
    end
    answer == 'y'
  end

  def display_goodbye_message
    puts "Thanks for playing! Goodbye!"
  end

  def play
    display_welcome_message
    loop do
      human.choose
      computer.choose
      display_moves
      display_winner
      break unless play_again?
    end
    display_goodbye_message
  end
end

RPSGame.new.play
