=begin
#RPS bonus features

1: Keep score

update the game so that the first play to reach 10 points wins

thoughts:

so now in the RPSGame class def, the play method (which is a single round)
should itself be invoked in a loop within another method that breaks when
either score is 10 or the user chooses to exit

-move current goodbye message  (change phrasing to "another round")
-needs to be modified so that the display_score is invoked before the prompt
to play again

so that would be:
def play_round
  play
  check_score -> undefined; should check if either score is 10 and invoke the
    display_grandwinner
  #at this point prompt to play another round
  #when loop break, display final goodbye message (move out of play method)
end

X-should have an initial message informing player that they are playing to 10
  points -> can be added to current welcoem_message
-should have scores that increment with each win
-should have additional display_runnning_score method to inform of current
  running score after each round
-if player chooses to replay, the score continues incrementing
-should have another loop somewhere so that player can opt to play again
  once a grandwinner is announded
-should have grandwinner to 1. announce a grand_winner and 2. to allow player
  to begin a new round or exit

nouns and verbs:
nouns:
(running) score, grandwinner, round
verbs:
increase (score)

more thoughts:
-a new score instance should be instantiated in the initialize method for
player; when a new game is started and new human and computer
instances are instantiated, this triggers the instiantiation of a new score for
each

STEPS:
X-first add scores of 0 to player initialize
X-output score for single round
-set up skeleton keeping score

set up running score with no break condition
-then place into loop and add handling breaking/replay prompt/goodbye message last

# class Score
#   attr_reader :score #available to get

  # def initialize
  #   @score = 0 -> should be initialized to 0
  # end

  def update_score
    score += 1 -> when a score instance should be incremented, 1 is added (protected?)
  end

  def display_score # should be placed in a loop somewhere so it isn't invoked 10 times
    puts "#{human.name}'s score is #{human.score}"
    puts "#{computer.name}'s score is #{computer.score}"
  end

  def grandwinner

  end

  # private
  # attr_writer :score #should not be available for reassignment anywhere else
end

# thoughts on nested loop: does it even make sense to have another loop?
#no -> add th additional scorekeeping methods to current loop. if socre hits 10,
#just announce grand winner and reset score to 0

=end
##NOTES: add constant for winning score and add clear screen method

# follow-up -- should the increment, reset, and attr_writer methods be protected?
# tried protecting and calling on human.score but it says 'protected method call'
# even though human.score is a score object?

=begin
#2: update to be rock paper scissors spock lizard

#steps:
-update text intro
-update computer choices
-update logic for winning

took ~15 minutes! mostly figureing out the logic and doing the typing. easy.

#3: make all five options into classes (is Rock class, Spock class )
#skipping for now

#4 Keep track of history of moves

-until player quits game, save a history of player choice and computer choice

thoughts:
data structures:
-maybe a hash with play and computer as key and list of moves as values?
doesnt really show who goes first etc
-actually current game play is that player will always go first. I think a 101
feature was to allow player to select who goes first? so maybe should assume
that player will always be first

-hash with round number as key and nested array of player and moves?
example: {
  round1 => [[rebecca, spock], [computer, lizard]] -> could add winner: [winner: computer] (maybe display below on new line?)
  round2 => [[rebecca, paper], [computer, rock]]
  ...could also added 3rd subarray holding grandwinner
  round13 => [[rebecca, paper], [computer, rock]]
  ##could add additional key for grandwinner
}

-create hash
-create round_number variable alongside score but do not reset
-after each round, set hash key to round number
-set value to array of [[name: move], [name: move]]...could add [winner: name] and [grandwinner: name]
-create display_scoreboard disaplying hash data scorebaord can be seen after each round
-consider how it will be displayed -> fancy lines and interpolation? would need
to consider size of words/names

notes: looked at shelter pets exercise, which uses a hash. based on that,
thinking a scoreboard class that holds the hash and incrementation method,
and then the display could be placed in displayable module


=end

#testing module
module Displayable # works -> all moved here from RPSGame class
  WINNER = 2

  def display_welcome_message
    puts "Welcome to Rock Paper Scissors Spock Lizard!"
    puts "The first player to win 10 rounds is the Grand Winner."
  end

  def display_moves
    puts "-----------------------------------------"
    puts "#{human.name} chose #{human.move}."
    puts "#{computer.name} chose #{computer.move}."
    puts "-----------------------------------------"
  end

  def display_winner
    if human.move > computer.move
      puts "#{human.name} won this round!"
    elsif human.move < computer.move
      puts "#{computer.name} won this round!"
    else
      puts "It's a tie!"
    end
  end

  def display_grandwinner
    if human.score.to_i == WINNER
      puts "#{human.name} is the Grand Winner!"
    elsif computer.score.to_i == WINNER
      puts "#{computer.name} is the Grand Winner!"
    end
  end

  def display_scoreboard
    "#{self.scoreboard}"
  end

  def display_score # added
    puts "--------------------------------------------"
    puts "#{human.name}'s score is #{human.score}"
    puts "#{computer.name}'s score is #{computer.score}"
    puts "Current round is: Round #{Player.display_round}" #current_round)} #####testing output
    puts "--------------------------------------------"
  end

  def display_goodbye_message
    puts "Thanks for playing! Goodbye!"
  end
end

# # #testing -- not working - would a modul work? or just including scoreboard in score?
# class Scoreboard
#   include Displayable

#   attr_accessor :board

#   def initialize
#     @board = {'test' => 'hi!'}
#   end

# #moving to rpsgam to rtest
#   # def log_score
#   #   self.board["Round #{human.round}"] = [["#{human.name}: #{human.move}"], ["#{computer.name}: #{computer.move}"]]
#   #     entry format:
#   #   self.board["Round #{human.round}"] = [["#{human.name}: #{human.move}"], ["#{computer.name}: #{computer.move}"], ["Winner: #{xx.name}"]]
#   # end

#   # def display_scoreboard
#   #   "#{self.board}"
#   # end
# end

###test class -> round should be changed to a class variable in Score
class Round #< Scoreboard
  include Displayable

  attr_reader :round

  def initialize
    super
    @round = 0
  end

  def increment_round
    self.round += 1 #added
  end

  def to_s
    round.to_s ## should this be self not score?
  end

  def to_i
    round.to_i # score.to_i
  end

  attr_writer :round
end

class Score
  include Displayable

  attr_reader :score

  def initialize
    @score = 0
  end

  def increment_score
    self.score += 1
  end

  def to_s
    score.to_s
  end

  def to_i
    score.to_i # score.to_i
  end

  #protected -> confused; trying to call on a score instance but isn't allowed
  attr_writer :score

  def reset_score
    self.score = 0
  end
end

class Move
  VALUES = %w(rock paper scissors spock lizard)
  HAL_VALUES = %w(scissors scissors scissors rock)
  R2D2_VALUE = "rock"
  C3PO_VALUES = %w(spock lizard)

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

  def spock?
    @value == 'spock'
  end

  def lizard?
    @value == 'lizard'
  end

  def >(other_move)
    if rock?
      return true if other_move.scissors? || other_move.lizard?
      return false
    elsif paper?
      return true if other_move.rock? || other_move.spock?
      return false
    elsif scissors?
      return true if other_move.paper? || other_move.lizard?
    elsif spock?
      return true if other_move.rock? || other_move.scissors?
      return false
    elsif lizard?
      return true if other_move.spock? || other_move.paper?
      return false
    end
  end

  def <(other_move)
    if rock?
      return true if other_move.paper? || other_move.spock?
      return false
    elsif paper?
      return true if other_move.scissors? || other_move.lizard?
      return false
    elsif scissors?
      return true if other_move.spock? || other_move.rock?
      return false
    elsif spock?
      return true if other_move.lizard? || other_move.paper?
      return false
    elsif lizard?
      return true if other_move.scissors? || other_move.rock?
      return false
    end
  end

  def to_s
    @value
  end
end

class Player
  attr_accessor :move, :name, :round, :score

  def initialize
    set_name
    @score = Score.new
    @@round = 0
  end

  def self.increment_round
    @@round += 1
  end

  def self.display_round
    @@round
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
      puts "Please choose rock, paper, scissors, spock, or lizard:"
      choice = gets.chomp.downcase
      break if Move::VALUES.include?(choice)
      puts "Sorry, that's not a valid choice."
    end
    self.move = Move.new(choice)
  end
end

class Computer < Player
  def set_name
    self.name = %w(R2D2 C3PO Walle Hal).sample
  end

  def choose
    if self.name == "Hal"
      self.move = Move.new(Move::HAL_VALUES.sample)
    elsif self.name == "R2D2"
      self.move = Move.new(Move::R2D2_VALUE)
    elsif self.name == "C3PO"
      self.move = Move.new(Move::C3PO_VALUES.sample)
    elsif self.name == "Walle"
      self.move = Move.new(Move::VALUES.sample)
    end
  end
end

class RPSGame
  include Displayable

  attr_accessor :human, :computer, :scoreboard

  @@scoreboard = {}
  #round should probably be here and and not in Player
  #consider returning this to the original state from video, renaming
  #single_round and then invoking # play inside another method to hold all the
  #scoring etc in a main_game
  def initialize
    @human = Human.new
    @computer = Computer.new
  end

  def update_score
    Player.increment_round
    if human.move > computer.move
      human.score.increment_score
    elsif human.move < computer.move
      computer.score.increment_score
    end
  end

  #test
  def track_score
    if human.move > computer.move
     "#{human.name} won"
    elsif human.move < computer.move
      "#{computer.name} won"
    else
      "Tie"
    end
  end

  def log_score #cannot figure this out and it should be in scorebaord class anyway
    @@scoreboard["Round #{Player.display_round}"] = ["#{human.name}: #{human.move}, #{computer.name}: #{computer.move}"]
  end

  def display_scoreboard
    last_round = @@scoreboard.keys.last
    puts '+----------------------------------------------------+'
    puts '| Current Round  |  Player Moves  |  Winner  |'
    puts '+----------------------------------------------------+'
    puts "| #{last_round}  |  #{@@scoreboard[last_round].first}  |  #{self.track_score} |"
    puts '+----------------------------------------------------+'
    "#{@@scoreboard}"
  end

  def play_again?
    answer = nil
    loop do
      puts "Would you like to play another round? (y/n)"
      answer = gets.chomp.downcase
      break if %w(y n).include?(answer)
      puts "Please type y or n."
    end
    answer == 'y'
  end

  def score_reset
    if human.score.to_i == WINNER || computer.score.to_i == WINNER
      human.score.reset_score
      computer.score.reset_score
    end
  end

  def play
    display_welcome_message
    loop do
      human.choose
      computer.choose
      display_moves
      display_winner
      update_score
      log_score ### test
      display_score
      display_scoreboard
      display_grandwinner
      score_reset
      break unless play_again?
    end
    display_goodbye_message
  end
end

RPSGame.new.play
