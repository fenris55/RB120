# OOP Medium 1 Exercises

#1

# class Machine

#   def start
#     # self.flip_switch(:on)
#     flip_switch(:on)
#   end

#   def stop
#     # self.flip_switch(:off)
#     flip_switch(:off)
#   end

#   def get_switch_state
#     @switch
#   end
#   private

#   # attr_writer :switch
#   attr_accessor :switch

#   def flip_switch(desired_state)
#     self.switch = desired_state
#   end
# end

# test1 = Machine.new
# test1.start
# test1.stop
# puts test1.get_switch_state

#2

# class FixedArray

#   def initialize(size)
#     @array = Array.new(size)
#   end

#   def [](index)
#     # @array[index]
#     #solution uses:
#     @array.fetch(index)
#     # this Array method raises an Index Error is index is out of range
#   end

#   def []=(index, el)
#     self[index] #from solution -> raises error for invalid index
#     @array[index] = el
#   end

#   def to_a
#     @array.clone #solution uses @array.clone
#     #converted fixed array object to regular array object
#     #ensures that modifications don't mutate the caller (like changing the size)
#   end

#   def to_s
#     "#{@array}" #solution uses -> to_a.to_s
#   end
# end

# fixed_array = FixedArray.new(5)
# puts fixed_array[3] == nil
# puts fixed_array.to_a == [nil] * 5

# fixed_array[3] = 'a'
# puts fixed_array[3] == 'a'
# puts fixed_array.to_a == [nil, nil, nil, 'a', nil]

# fixed_array[1] = 'b'
# puts fixed_array[1] == 'b'
# puts fixed_array.to_a == [nil, 'b', nil, 'a', nil]

# fixed_array[1] = 'c'
# puts fixed_array[1] == 'c'
# puts fixed_array.to_a == [nil, 'c', nil, 'a', nil]

# fixed_array[4] = 'd'
# puts fixed_array[4] == 'd'
# puts fixed_array.to_a == [nil, 'c', nil, 'a', 'd']
# puts fixed_array.to_s == '[nil, "c", nil, "a", "d"]'

# puts fixed_array[-1] == 'd'
# puts fixed_array[-4] == 'c'

# begin
#   fixed_array[6]
#   puts false
# rescue IndexError
#   puts true
# end

# begin
#   fixed_array[-7] = 3
#   puts false
# rescue IndexError
#   puts true
# end

# begin
#   fixed_array[7] = 3
#   puts false
# rescue IndexError
#   puts true
# end

#3
# class Student
#   def initialize(name='name', year='year')
#     @name = name
#     @year = year
#   end
# end

# class Graduate < Student
#   def initialize(name, year, parking)
#     super(name, year)
#     @parking = parking
#   end
# end

# class Undergraduate < Student
#   def initialize(name, year)
#     super
#   end
# end

# class NewStudent < Student
#   def initialize
#     super()
#   end
# end

# sally = Graduate.new('Sally', 2019, '12-D')
# bob = Undergraduate.new('Bob', 2021)
# new_student = NewStudent.new

# p sally
# p bob
# p new_student

#4
# Thoughts:
# -need a fixed array as seen in the previous exericise
#   -size is passed in at instantiation
#   -default value nil

# -instance variable to track oldest_element
#   -update each time something is added
#   -access for removing an item (oldest element should be removed and then
#     needs to be reassigned to new oldest element)

#     -so if oldest element is removed, oldest_element needs to reassigned to point
#     to the new oldest element, which means the state/order of all elements need
#     to be track and updated -> hash?


# -iteration to return first empty space/nil value (for adding a new element)

=begin
# Lesson solution:

class CircularQueue
  attr_accessor :array, :start_index, :end_index
  def initialize(size) #fixed array object with attribute @array
    @buffer = [nil] * size
    @next_position = 0
    @oldest_position = 0
  end

  def enqueue(object)
    unless @buffer[@next_position].nil?
      @oldest_position = increment(@next_position)
    end

    @buffer[@next_position] = object
    @next_position = increment(@next_position)
  end

  def dequeue
    value = @buffer[@oldest_position]
    @buffer[@oldest_position] = nil
    @oldest_position = increment(@oldest_position) unless value.nil?
    value
  end

  private

  #this is sort of using modulo to create a loop
  #the index passed in will always increment by 1 unless it is equal to the
  #array's max sixe -> then module will return 0, resetting the index to 0
  def increment(position)
    (position + 1) % @buffer.size
  end
end

test1 = CircularQueue.new(5)
p test1
p test1.enqueue('test1')
p test1.enqueue('test2')
p test1.enqueue('test3')
p test1.enqueue('test4')
p test1.enqueue('test5')

p test1
p test1.dequeue
p test1

#lesson solution and my tests above; student solutions below:

# Satya's solution
class CircularQueue
  def initialize(size)
    @stack = []
    @size = size
  end

  def enqueue(object)
    dequeue if @stack.size == @size
    @stack.push(object)
  end

  def dequeue
    @stack.shift
  end
end
#joseph's solution:

class CircularQueue

  def initialize(size)
    @circle = Array.new(size)
    @size = size
  end

  def enqueue(new_item)
    circle.push(new_item)
    circle.shift if circle.size > size
  end

  def dequeue
    circle.compact!
    circle.shift
  end

  private

  attr_accessor :circle, :size
end

queue = CircularQueue.new(3)
puts queue.dequeue == nil

queue.enqueue(1)
queue.enqueue(2)
puts queue.dequeue == 1

queue.enqueue(3)
queue.enqueue(4)
puts queue.dequeue == 2

queue.enqueue(5)
queue.enqueue(6)
queue.enqueue(7)
puts queue.dequeue == 5
puts queue.dequeue == 6
puts queue.dequeue == 7
puts queue.dequeue == nil

queue = CircularQueue.new(4)
puts queue.dequeue == nil

queue.enqueue(1)
queue.enqueue(2)
puts queue.dequeue == 1

queue.enqueue(3)
queue.enqueue(4)
puts queue.dequeue == 2

queue.enqueue(5)
queue.enqueue(6)
queue.enqueue(7)
puts queue.dequeue == 4
puts queue.dequeue == 5
puts queue.dequeue == 6
puts queue.dequeue == 7
puts queue.dequeue == nil

=end
# 5
=begin
P: create a stack machine program. The 'stack' is an array. #push and #pop can
be used to add or remove the most recent elements on the stack. A single variable
can be the register. Create a mehtod definition for each of the stack operations.
When an operation is performed, the most recent element on the stack is removed,
the operation is performed with that stack element and the value saved in the
register, and the result is saved to the register.

Consider from an OOP perspective:
-- Does this mean that each element in the stack
should be an object?
--stack and register should both be instance variables

spike: --- idk. Think this is overcomplicating it -- don't think these need to be
objects

nouns:
register, stack, stack value

rules:
input: string (of method names and numbers)
-initialize register to 0
-assume integer operation (for DIV and MOD)
-produce error and stop operations if:
  -stack is empty
  -incorrect input
#eval should
-integer input places number in register

# require 'set'

# class MinilangError < StandardError; end
# class BadTokenError < MinilangError; end
# class EmptyStackError < MinilangError; end

# class Minilang
#   ACTIONS = Set.new %w(PUSH ADD SUB MULT DIV MOD POP PRINT)

# def initialize(program)
#     @program = program
#   end

#   def eval
#     @register = 0
#     @stack = []
#     @program.split.each { |token| eval_token(token) }
#     rescue MinilangError => error
#       puts error.message
#   end

#   private

#   def eval_token(token)
#     if ACTIONS.include?(token)
#       send(token.downcase)
#     elsif token =~ /\A[-+]?\d+\z/
#       @register = token.to_i
#     else
#       raise BadTokenError, "Invalid token: #{token}"
#     end
#   end

#   def push
#     @stack.push(@register)
#   end

#   def pop
#     raise EmptyStackError, "Empty stack!" if @stack.empty?
#     @register = @stack.pop
#   end

#   def add
#     @register += pop #register + stack.pop
#   end

#   def sub
#     @register -= pop
#   end

#   def mult
#     @register *= pop
#   end

#   def div
#     @register /= pop
#   end

#   def mod
#     @register %= pop
#   end

#   def print
#     puts @register
#   end
# end

# Minilang.new('PRINT').eval
# 0

# Minilang.new('5 PUSH 3 MULT PRINT').eval
# 15

# Minilang.new('5 PRINT PUSH 3 PRINT ADD PRINT').eval
# # 5
# # 3
# # 8

# Minilang.new('5 PUSH 10 PRINT POP PRINT').eval
# # 10
# # 5

# Minilang.new('5 PUSH POP POP PRINT').eval
# # Empty stack!

# Minilang.new('3 PUSH PUSH 7 DIV MULT PRINT ').eval
# # 6

# Minilang.new('4 PUSH PUSH 7 MOD MULT PRINT ').eval
# # 12

# Minilang.new('-3 PUSH 5 XSUB PRINT').eval
# # Invalid token: XSUB

# Minilang.new('-3 PUSH 5 SUB PRINT').eval
# # 8

# Minilang.new('6 PUSH').eval
# # (nothing printed; no PRINT commands)

=end

#6
# Problem:
# write a number guesing game. The player can select a number between 1 and 100.
# Computer should tell the player whether their guess is too high or too low.
# Player has 7 guesses. If they guess the correct number, they win. If they use
# all 7 guesses, they lose.

# nouns:
# player, number, guesses

# verbs:
# guess

# spike:

# class Player
#   attr_accessor :guesses, :current_guess

#   def initialize
#     @guesses = 7
#     @current_guess = 0
#   end

#   def >(other)
#     current_guess > other
#   end

#   def <(other)
#     current_guess < other
#   end

#   def ==(other)
#     current_guess == other
#   end
# end

# class GuessingGame
#   attr_accessor :player, :number

#   def initialize
#     @player = Player.new
#     @number = (1..100).to_a.sample
#   end

#   def update_player_info(guess) #does this functionality belong in the player class?
#     player.current_guess = guess
#     player.guesses -= 1
#   end

#   def player_move
#     display_remaining_guesses
#     loop do
#     puts "Enter a number between 1 and 100:"
#       entry = gets.chomp.to_i
#       if (1..100) === entry
#         update_player_info(entry)
#         break
#       else
#         puts "Invalid guess. Enter a number between 1 and 100:"
#       end
#     end
#   end

#   def compare_guess
#     if player > number
#       puts "Your guess is too high."
#     elsif player < number
#       puts "Your guess is too low."
#     elsif player == number
#       puts "That's the number!"
#     end
#   end

#   def player_win
#     player == number
#   end

#   def out_of_guesses
#     player.guesses == 0
#   end

#   def game_over?
#     player_win || out_of_guesses
#   end

#   def display_remaining_guesses
#     puts "You have #{player.guesses} guesses remaining."
#   end

#   def display_outcome
#     if player_win
#       puts
#       puts "You won!"
#     elsif
#       out_of_guesses
#       puts
#       puts "You lost!"
#       puts
#       puts "The winning number was: #{number}. Better luck next time!"
#       puts
#     end
#   end

#   def play
#     loop do
#       player_move
#       compare_guess
#       break if game_over?
#     end
#     display_outcome
#   end
# end

# game = GuessingGame.new
# game.play

#LS Solution:

# class GuessingGame
#   MAX_GUESSES = 7
#   RANGE = 1..100

#   RESULT_OF_GUESS_MESSAGE = {
#     high: "Your number is too high.",
#     low: "Your number is too low.",
#     match: "That's the number!"
#   }.freeze

#   WIN_OR_LOSE = {
#     high: :lose,
#     low: :lose,
#     match: :win
#   }.freeze

#   RESULT_OF_GAME_MESSAGE = {
#     win: "You won!",
#     lose: "You have no more guesses. You lost!"
#   }.freeze

#   def initialize
#     @secret_number = nil
#   end

#   def play
#     reset
#     game_result = play_game
#     display_game_end_message(game_result)
#   end

#   private

#   def reset
#     @secret_number = rand(RANGE)
#   end

#   def play_game
#     result = nil
#     MAX_GUESSES.downto(1) do |remaining_guesses|
#       display_guesses_remaining(remaining_guesses)
#       result = check_guess(obtain_one_guess)
#       puts RESULT_OF_GUESS_MESSAGE[result]
#       break if result == :match
#     end
#     WIN_OR_LOSE[result]
#   end

#   def display_guesses_remaining(remaining)
#     puts
#     if remaining == 1
#       puts "You have 1 guess remaining."
#     else
#       puts "You have #{remaining} guesses remaining."
#     end
#   end

#   def obtain_one_guess
#     loop do
#       print "Enter a number between #{RANGE.first} and #{RANGE.last}: "
#       guess = gets.chomp.to_i
#       return guess if RANGE.cover?(guess)
#       print "Invalid guess"
#     end
#   end

#   def check_guess(guess_value)
#     return :match if guess_value == @secret_number
#     return :low if guess_value < @secret_number
#     :high
#   end

#   def display_game_end_message(result)
#     puts "", RESULT_OF_GAME_MESSAGE[result]
#   end
# end

# game = GuessingGame.new
# game.play

#7:
#LS solution copied from above/previous problem
#Problem:
# 1.allow player to enter min and max value for the range of possible numbers
# 2. use the given algorithm to alter adjust the numberof allowed gusses based
# on the size of the number range

#had some trouble getting the range but got it working. Maybe a little messy.
#did not successfully use their algorithm for number of guesses.
# class GuessingGame
#   MAX_GUESSES = 7
#   RANGE = (@range_min..@range_max)

#   RESULT_OF_GUESS_MESSAGE = {
#     high: "Your number is too high.",
#     low: "Your number is too low.",
#     match: "That's the number!"
#   }.freeze

#   WIN_OR_LOSE = {
#     high: :lose,
#     low: :lose,
#     match: :win
#   }.freeze

#   RESULT_OF_GAME_MESSAGE = {
#     win: "You won!",
#     lose: "You have no more guesses. You lost!"
#   }.freeze

#   def initialize(range_min, range_max)
#     @secret_number = nil
#     @range_min = range_min
#     @range_max = range_max
#   end

#   def play
#     reset
#     game_result = play_game
#     display_game_end_message(game_result)
#   end

#   private

#   def reset
#     # @secret_number = rand(RANGE)
#     @secret_number = (@range_min..@range_max).to_a.sample
#   end

#   def play_game
#     result = nil
#     MAX_GUESSES.downto(1) do |remaining_guesses|
#       display_guesses_remaining(remaining_guesses)
#       result = check_guess(obtain_one_guess)
#       puts RESULT_OF_GUESS_MESSAGE[result]
#       break if result == :match
#     end
#     WIN_OR_LOSE[result]
#   end

#   def display_guesses_remaining(remaining)
#     puts
#     if remaining == 1
#       puts "You have 1 guess remaining."
#     else
#       puts "You have #{remaining} guesses remaining."
#     end
#   end

#   def obtain_one_guess
#     loop do
#       print "Enter a number between #{@range_min} and #{@range_max}: "
#       guess = gets.chomp.to_i
#       return guess if (@range_min..@range_max).to_a.include?(guess)
#       puts "Invalid guess"
#     end
#   end

#   def check_guess(guess_value)
#     return :match if guess_value == @secret_number
#     return :low if guess_value < @secret_number
#     :high
#   end

#   def display_game_end_message(result)
#     puts "", RESULT_OF_GAME_MESSAGE[result]
#   end
# end

# game = GuessingGame.new(1, 897)
# game.play

#looking at solution for number of guesses:

# class GuessingGame

#   RESULT_OF_GUESS_MESSAGE = {
#     high: "Your number is too high.",
#     low: "Your number is too low.",
#     match: "That's the number!"
#   }.freeze

#   WIN_OR_LOSE = {
#     high: :lose,
#     low: :lose,
#     match: :win
#   }.freeze

#   RESULT_OF_GAME_MESSAGE = {
#     win: "You won!",
#     lose: "You have no more guesses. You lost!"
#   }.freeze

#   def initialize(range_min, range_max)
#     @secret_number = nil
#     @range = range_min..range_max
#     @max_guesses = Math.log2(range_max - range_min + 1).to_i + 1
#   end

#   def play
#     reset
#     game_result = play_game
#     display_game_end_message(game_result)
#   end

#   private

#   def reset
#     @secret_number = rand(@range)
#   end

#   def play_game
#     result = nil
#     @max_guesses.downto(1) do |remaining_guesses|
#       display_guesses_remaining(remaining_guesses)
#       result = check_guess(obtain_one_guess)
#       puts RESULT_OF_GUESS_MESSAGE[result]
#       break if result == :match
#     end
#     WIN_OR_LOSE[result]
#   end

#   def display_guesses_remaining(remaining)
#     puts
#     if remaining == 1
#       puts "You have 1 guess remaining."
#     else
#       puts "You have #{remaining} guesses remaining."
#     end
#   end

#   def obtain_one_guess
#     loop do
#       print "Enter a number between #{@range.first} and #{@range.last}: "
#       guess = gets.chomp.to_i
#       return guess if @range.cover?(guess)
#       puts "Invalid guess"
#     end
#   end

#   def check_guess(guess_value)
#     return :match if guess_value == @secret_number
#     return :low if guess_value < @secret_number
#     :high
#   end

#   def display_game_end_message(result)
#     puts "", RESULT_OF_GAME_MESSAGE[result]
#   end
# end

# game = GuessingGame.new(1, 897)
# game.play

#8
#my original solution, with Comparable mixed in:

# class Card
#   include Comparable

#   VALUES = {1 => 1, 2 => 2, 3 => 3, 4 => 4, 5 => 5, 6 => 6, 7 => 7, 8 => 8,
#             9 => 9, 10 => 10, "Jack" => 11, "Queen" => 12, "King" => 13,
#             "Ace" => 14 }

#   attr_reader :rank, :suit

#   def initialize(rank, suit)
#     @rank = rank
#     @suit = suit
#   end


#   def <=>(other)
#     VALUES[self.rank] <=> VALUES[other.rank]
#   end

#   def to_s
#     "#{rank} of #{suit}"
#   end

# end

# cards = [Card.new(2, 'Hearts'),
#         Card.new(10, 'Diamonds'),
#         Card.new('Ace', 'Clubs')]
# puts cards
# puts cards.min == Card.new(2, 'Hearts')
# puts cards.max == Card.new('Ace', 'Clubs')

# cards = [Card.new(5, 'Hearts')]
# puts cards.min == Card.new(5, 'Hearts')
# puts cards.max == Card.new(5, 'Hearts')

# cards = [Card.new(4, 'Hearts'),
#         Card.new(4, 'Diamonds'),
#         Card.new(10, 'Clubs')]
# puts cards.min.rank == 4
# puts cards.max == Card.new(10, 'Clubs')

# cards = [Card.new(7, 'Diamonds'),
#         Card.new('Jack', 'Diamonds'),
#         Card.new('Jack', 'Spades')]
# puts cards.min == Card.new(7, 'Diamonds')
# puts cards.max.rank == 'Jack'

# cards = [Card.new(8, 'Diamonds'),
#         Card.new(8, 'Clubs'),
#         Card.new(8, 'Spades')]
# puts cards.min.rank == 8
# puts cards.max.rank == 8


## LS solution:

# class Card
#   include Comparable

#   VALUES = {"Jack" => 11, "Queen" => 12, "King" => 13, "Ace" => 14 }
#   RANK_VALUES = {"Diamonds" => 1, "Clubs" => 2, "Hearts" => 3, "Spades" => 4}

#   attr_reader :rank, :suit

#   def initialize(rank, suit)
#     @rank = rank
#     @suit = suit
#   end

#   #my attempt: it's returning the correct card (I had the VALUES constant
#   #populated with all cards for easy access), but isn't evaluating to true
#   #-- not sure why

#   ##FOLLOW UP -> my approach worked. But both solutions using <=> need to
#   # include the Comparable module in the class definition in torder to allow the
#   # program to acess the <=> method.

#   #lesson solution splits this logic into 2 methods: see below:
#   # def <=>(other)
#   #   VALUES[self.rank] <=> VALUES[other.rank]
#   # end

#   #here, the first rank is being used to search the VALUES hash; if the card
#   #isn't included (ie, it's a number card), the second rank argument is serving as
#   #the default value. If rank isn't found as a hash key, we call the rank getter
#   #method and rely on that instead
#   def value
#     VALUES.fetch(rank, rank)
#   end

#   ## attempt at implementing further exploration -> idk if it works
#   def <=>(other)
#     if value == other.value
#       (value + RANK_VALUES[self.suit]) <=> (other.value + RANK_VALUES[other.suit])
#     else
#       value <=> other.value
#     end
#   end

#   def to_s
#     "#{rank} of #{suit}"
#   end

# end

# cards = [Card.new(2, 'Hearts'),
#         Card.new(10, 'Diamonds'),
#         Card.new('Ace', 'Clubs')]
# puts cards
# puts cards.min == Card.new(2, 'Hearts')
# puts cards.max == Card.new('Ace', 'Clubs')

# cards = [Card.new(5, 'Hearts')]
# puts cards.min == Card.new(5, 'Hearts')
# puts cards.max == Card.new(5, 'Hearts')

# cards = [Card.new(4, 'Hearts'),
#         Card.new(4, 'Diamonds'),
#         Card.new(10, 'Clubs')]
# puts cards.min.rank == 4
# puts cards.max == Card.new(10, 'Clubs')

# cards = [Card.new(7, 'Diamonds'),
#         Card.new('Jack', 'Diamonds'),
#         Card.new('Jack', 'Spades')]
# puts cards.min == Card.new(7, 'Diamonds')
# puts cards.max.rank == 'Jack'

# cards = [Card.new(8, 'Diamonds'),
#         Card.new(8, 'Clubs'),
#         Card.new(8, 'Spades')]
# puts cards.min.rank == 8
# puts cards.max.rank == 8

### Further Exploration thoughts:

#Not planning to implement this, but a thoguht:
# each suit could be assigned a number (1-4); that number could be added to the
# rank value, so a higher rank suit could be associated with a higher numric value

#for execution: within the custom <=> method, IF values are equal, then add the
#appropriate suit value to the current value (store suit values in hash); then
#execute <=>

#9
#Checked solution:

# class Card
#   include Comparable
#   attr_reader :rank, :suit

#   VALUES = { 'Jack' => 11, 'Queen' => 12, 'King' => 13, 'Ace' => 14 }

#   def initialize(rank, suit)
#     @rank = rank
#     @suit = suit
#   end

#   def to_s
#     "#{rank} of #{suit}"
#   end

#   def value
#     VALUES.fetch(rank, rank)
#   end

#   def <=>(other_card)
#     value <=> other_card.value
#   end
# end


# class Deck
#   RANKS = ((2..10).to_a + %w(Jack Queen King Ace)).freeze
#   SUITS = %w(Hearts Clubs Diamonds Spades).freeze

#   def initialize
#     reset
#   end

#   def draw
#     reset if @deck.empty?
#     @deck.pop
#   end

#   private

#   def reset
#     @deck = RANKS.product(SUITS).map do |rank, suit|
#       Card.new(rank, suit)
#     end

#     @deck.shuffle!
#   end
# end


# deck = Deck.new
# drawn = []
# 52.times { drawn << deck.draw }
# p drawn.count { |card| card.rank == 5 } == 4
# p drawn.count { |card| card.suit == 'Hearts' } == 13

# drawn2 = []
# p 52.times { drawn2 << deck.draw }
# p drawn != drawn2 # Almost always.

#10

class Card
  include Comparable
  attr_reader :rank, :suit

  VALUES = { 'Jack' => 11, 'Queen' => 12, 'King' => 13, 'Ace' => 14 }

  def initialize(rank, suit)
    @rank = rank
    @suit = suit
  end

  def to_s
    "#{rank} of #{suit}"
  end

  def value
    VALUES.fetch(rank, rank)
  end

  def <=>(other_card)
    value <=> other_card.value
  end
end


class Deck
  RANKS = ((2..10).to_a + %w(Jack Queen King Ace)).freeze
  SUITS = %w(Hearts Clubs Diamonds Spades).freeze

  def initialize
    reset
  end

  def draw
    reset if @deck.empty?
    @deck.pop
  end

  private

  def reset
    @deck = RANKS.product(SUITS).map do |rank, suit|
      Card.new(rank, suit)
    end

    @deck.shuffle!
  end
end

# Include Card and Deck classes from the last two exercises.

class PokerHand
  def initialize(cards)
    @cards = []
    @rank_count = Hash.new(0)

    5.times do
      card = cards.draw
      @cards << card
      @rank_count[card.rank] += 1
    end
  end

  def print
    puts "Your current hand is: "
    puts @cards
  end

  def evaluate
    case
    when royal_flush?     then 'Royal flush'
    when straight_flush?  then 'Straight flush'
    when four_of_a_kind?  then 'Four of a kind'
    when full_house?      then 'Full house'
    when flush?           then 'Flush'
    when straight?        then 'Straight'
    when three_of_a_kind? then 'Three of a kind'
    when two_pair?        then 'Two pair'
    when pair?            then 'Pair'
    else                       'High card'
    end
  end

  private

  def royal_flush?
    straight_flush? && @cards.min.rank == 10
  end

  def straight_flush?
    flush? && straight?
  end

  def four_of_a_kind?
    n_of_a_kind?(4)
  end

  def full_house?
    n_of_a_kind?(3) && n_of_a_kind?(2)
  end

  def flush?
    suit = @cards.first.suit
    @cards.all? { |card| card.suit == suit }
  end

  def straight?
    return false if @rank_count.any? { |_, count| count > 1 }
    @cards.min.value == @cards.max.value - 4
  end

  def n_of_a_kind?(number)
    @rank_count.one? {|_, count| count == number }
  end

  def three_of_a_kind?
    n_of_a_kind?(3)
  end

  def two_pair?
    @rank_count.select { |_, count| count == 2 }.size == 2
  end

  def pair?
    n_of_a_kind?(2)
  end
end

hand = PokerHand.new(Deck.new)
hand.print
puts hand.evaluate

# Danger danger danger: monkey
# patching for testing purposes.
class Array
  alias_method :draw, :pop
end

# Test that we can identify each PokerHand type.
hand = PokerHand.new([
  Card.new(10,      'Hearts'),
  Card.new('Ace',   'Hearts'),
  Card.new('Queen', 'Hearts'),
  Card.new('King',  'Hearts'),
  Card.new('Jack',  'Hearts')
])
puts hand.evaluate == 'Royal flush'

hand = PokerHand.new([
  Card.new(8,       'Clubs'),
  Card.new(9,       'Clubs'),
  Card.new('Queen', 'Clubs'),
  Card.new(10,      'Clubs'),
  Card.new('Jack',  'Clubs')
])
puts hand.evaluate == 'Straight flush'

hand = PokerHand.new([
  Card.new(3, 'Hearts'),
  Card.new(3, 'Clubs'),
  Card.new(5, 'Diamonds'),
  Card.new(3, 'Spades'),
  Card.new(3, 'Diamonds')
])
puts hand.evaluate == 'Four of a kind'

hand = PokerHand.new([
  Card.new(3, 'Hearts'),
  Card.new(3, 'Clubs'),
  Card.new(5, 'Diamonds'),
  Card.new(3, 'Spades'),
  Card.new(5, 'Hearts')
])
puts hand.evaluate == 'Full house'

hand = PokerHand.new([
  Card.new(10, 'Hearts'),
  Card.new('Ace', 'Hearts'),
  Card.new(2, 'Hearts'),
  Card.new('King', 'Hearts'),
  Card.new(3, 'Hearts')
])
puts hand.evaluate == 'Flush'

hand = PokerHand.new([
  Card.new(8,      'Clubs'),
  Card.new(9,      'Diamonds'),
  Card.new(10,     'Clubs'),
  Card.new(7,      'Hearts'),
  Card.new('Jack', 'Clubs')
])
puts hand.evaluate == 'Straight'

hand = PokerHand.new([
  Card.new('Queen', 'Clubs'),
  Card.new('King',  'Diamonds'),
  Card.new(10,      'Clubs'),
  Card.new('Ace',   'Hearts'),
  Card.new('Jack',  'Clubs')
])
puts hand.evaluate == 'Straight'

hand = PokerHand.new([
  Card.new(3, 'Hearts'),
  Card.new(3, 'Clubs'),
  Card.new(5, 'Diamonds'),
  Card.new(3, 'Spades'),
  Card.new(6, 'Diamonds')
])
puts hand.evaluate == 'Three of a kind'

hand = PokerHand.new([
  Card.new(9, 'Hearts'),
  Card.new(9, 'Clubs'),
  Card.new(5, 'Diamonds'),
  Card.new(8, 'Spades'),
  Card.new(5, 'Hearts')
])
puts hand.evaluate == 'Two pair'

hand = PokerHand.new([
  Card.new(2, 'Hearts'),
  Card.new(9, 'Clubs'),
  Card.new(5, 'Diamonds'),
  Card.new(9, 'Spades'),
  Card.new(3, 'Diamonds')
])
puts hand.evaluate == 'Pair'

hand = PokerHand.new([
  Card.new(2,      'Hearts'),
  Card.new('King', 'Clubs'),
  Card.new(5,      'Diamonds'),
  Card.new(9,      'Spades'),
  Card.new(3,      'Diamonds')
])
puts hand.evaluate == 'High card'