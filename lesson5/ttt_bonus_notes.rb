=begin

# Notes from creating Tic Tac Toe bonus features.

List of implemented features includes:
-human name
-computer name
-human can chose marker (X or 0)
-added score - grandwinner announced at 5 points
-formatted output for list of available spaces (added commas and 'or')
-created Human and Computer subclasses (inherit from Player)
-created Displayable module (holds most output for TTTGame class)
-added computer intellignt play featueres:
  -if available, computer will choose center square first
  -if a square has 2 identical markers, computer will choose third square

Not implemented:
-offensive play:
  -currently, computer does not distinguish between 2 human's markers and its
  own; if computer has 2 ina row and human has 2 in a row, computer will place
  marker in which line is evaluated first.

  At the bottom of this documents are some notes, Computer class helper methods,
  and Board class methods that I think are close to working (intelligent play
  and the other varient of two_identical_markers?). Current, they are not
  evaluating when called from the Computer class.

-choose who goes first
  -did not enable choice for first move

NOTES:
*notes, thoughts, practice methods, and additional code from planning bonus
feature

=begin
Bonus Feature Notes:

Added Features:
-let human pick marker
-add player names
-improve 'join' output for list of numbers (added commas and 'or')
-add computer AI ###not added yet
  -offensive (if computer has 2 in a row, mark 3rd)
  -defensive (if player has 2 in a row, marker 3)
  -choose middle space when available

1. allow player to choose marker
 notes:
 -currently, marker is assign when a new game is instantiated.

 -leave at initialization, but set initialize markers to empty spaces

 def pick_player_piece:
 -prompt player to choose a marker
 -validate entry
 -reassign HUMAN_MARKER to human's choice (remove from initializiation?)

 separate method:
 def pick_computer piece
 -assign to computer whichever piece the human has not chosen

 3rd method:
 -place both methods into a "set_up_games" method and call in main_game after
 welcome message (adding names can eventually be called here too)

Problems:
currently, when a new game kicks of the first thing loaded is the constants --
includind the assignments to HUMAN_mARKER and COMPUTER MARKER. These are no
longer static, so maybe they should no longer be contstants -- just instance
variables.

2. & 3.
Allow names for player and computer

Names should be entered as part of initila setup (when markers are chosen)

Player:
-add instance variable @name to player class and initialize to empty string
-add invokations of assign_player_name and assign_computer_name to set_game method

def assign_player_name
-prompt user for input, validate, save to human.name

def assign_computer_name
-create array of names, select one at random, svae to computer.name

use string interpolation to display names in text output

Keep Score:
-should initialize a new score in the outer loop'
-after each round, increment scrore according to winner
-if score reaches 5, announce grandwinner and reset

score -> should be an attribute of each player, and the responsiblility of the
game to compare and then do something

add @score to Player constructor method
initilaize to 0
(each playr now has a name, a marker, and a score, which starts at 0)

with TTTGame:

def update_score
board.winning_marker == 'X'
  human.score += 1
elsif board.winning_marker = 'O'
  computer.score += 1
end

Thoughts on computer AI
-methods speicifcally defining computer inteliigent play aren't really relevant
to the game itself -> it's computer behavior. BUT computer is a player instance,
and this behavior is also not relevant to a human player.

Options:
1. place computer behavior into player class and just ignore for human
  (dislike -- all behavior should be relevant to all player objects)
2. split human and computer into subclasses that inherit from player, like in RPS
  (also dislike -- would be a lot of work and would take a lot of refactoring)
3. add a module and mixin to player class.
  (Don't love this either -- the computer behaviors will still be enabled for a
  human player)
4.split player into human and computer classes but keep everything else the same
  except for mixing in a computer Ai module to the comptuer class

  -currently player class is really only handling initialization --doesn't
  hold any methods so I think maybee there would be no major impact by spltting
  them into differnet classes?

  Test the above first. If everything still works, try definieling a computer
  AI module and mixing it into the computer class. Biggest issue will be
  accessing the board. There'a lot going on to determine the winner in the
  board class method, and those will need to inform how the cpmputer moves--
  until that logic is just imitated here?

### Refactoring thoughts:
Would be bestto split computer ad human into subclasses.
Then separate behaviors for:
  -choosing name
  -choosing marker
  -choosing which player goes first
can be placed into the appropriate subclass (currently, these methods are in the
main game engine, but they are player behaviros and shouldn't really be a
concern of the game)

biggest challenge: \
-enabling a Computer_AI module to access the board and any other data it
need to decide how the player should move

furher thoughts --> computer AI behavior would be unique to the computer class;
it wouldn't really make sense to uput it in a midule since it wouldn't need to
be made available to anuy other class.

So, best approach is to:
-subclass human and computer from player
-place computer AI methods into the computer class
-place behaviors for choosing name, marker, and first turn into respective
classes
-leave constructor method in player superclass -> will need to change
initialization in TTTGame to initilaize human and computer to the correct
classes, but I think everything else can remain the same
computer and human

returning to AI logic:
-define in computer class
-take 1 argument (hash) ??
  - pick apart logic in three_identical_markers

-so, computer ONLY needs access to line_with_two_markers(with argument board..)
and another method to choose space 5 if empty
-place into computer_ai method

making a mess. notes:

currently:
-three_identical_markers (boolean return) is used to id if there are
3 matching markers
-winning marker returns that marker (to determine winner)

need to utilize same logic but use:
-two_identical_markers to id if a line has 2 of the same marker
-missing_marker return the key of the value with the INITIAL_MARKER

Plan:
-subclass human and computer
-create an inteliigent_play method for computer
-feed it:
  -offensive play
  -defensive play
  -pick 5
-move computer/player specific methods to each subclass
-create module for Displayable

Challenge:
-consider x-only misere game
=end

### Only issue is that computer offensive play is not enabled
# methods in Board got a little messy trying to handle that
# in Computer, there is a commented-out outline for placing each type of
#computer move into its own helper method.

=begin

struck on computer offensive/defensve logic.

-currently, Board#winning_marker iterates over the WINNING_LINES coonstant, an array
holding th subarray combinationso fthe winning lines. on each iteration, a
subarray of numbers/hash keys: (is, [1, 2, 3]) passes into the block. The
#values_at method is called on the @squares hash (where these numbers are keys),
returning an array of the value for each number/array key. The return value is save
in method local variable squares (at this point, squares holds 3 Squares objects,)
each of which has a @marker atribute. The attribute will either be the INITIAL_MARKER
(empty space) or one of the player markers.

The squares array if passed to the Board#three_winning_markers? method. If this
evaluates to true, all three marker attributes for the Squares ojects in the array
are the same, which means there is a winning. When true is return, #winning_marker
selects the first Square elemnet int he current array, and then selects the marker
for that Sqaure object (since they are all the same). It then returns the marker.
Based on which player is assigned that marekr, we can then identify which player
hash won. If three_identical markers returns false, iteration continues over
the next line.

Three-idenitcal_marker works by take the array passed in (currently the 3 square
objects assicoated with the given keys), selecting the Square objects that are
marked (-> the marker attribute is no longer the empty space) and transforming
those marked squares to just the marker attribute. We know that a square has
three in a row if any of these arrays have a size3 of 3 after selection and
transformation and the max and min are the same (which means they are the same marker)

challenge: apply this logic to 2 markers

1.
can write a two_identical_squares logic that does the same thing; simply changing
the number to 2 will identify whether any line has a two in a row. The problem
is that currently, iteration stops and returns a line as soon as this condition
is met. We need more control over this -> want to first check if any square has
3 of the computer's markers in a row. Only if all lines evaluate to false should
we then check to see if the player has 2 in a row.

So, instead of transforming to any marker, we need to transform to first one
marker and then another. Maybe: two_identical_lins can take 2 arguments ->
square (the array of Square objects passed in) and target_marker (then when
selection is performing, only select the Square objects with target marker.
During implementation this can be called twice; first with the computer's marker
passed as tarket marked, and then with the player's marked passed as target_marker)

Ok, that logic works for the inner checking method. Now, that boolean will pass
back to the outer method it is called on (which will now need to have the target_marker
passed into it?? Current, winning_marker takes that boolean and simply retruns a marker.
We don't want that here -- we want to return the number/key from the line being
iterated over that is an empty space, so that computer can then place its marker
at that space. So one two_identical markers(target_marker) evaluates to true,
want to select from line the number whose value(Square object) has INITIAL_MARKER
as the marker

-------------------------------------------------------------------------------
#these two belong in board class - I think they may work for offensive play
by calling twice in Computer class, first passing computer marker and then
passing player marker. However, my execution kept skipping over them.

  def two_identical_markers?(squares, target_marker) ###this should now work to ID squares with 2 target markers (r=invoke twice)
    markers = squares.select { |k, v| v.marker == target_marker}.collect(&:marker)
    return false if markers.size != 2
    markers.min == markers.max
  end

  def intelligent_play(target_marker)
    WINNING_LINES.each do |line|
      squares = @squares.values_at(*line)
      if two_identical_markers?(squares) #-> line has a space we want

     target_space =  line.select { |key| @squares.key.marker.unmarked? #not sure if this should be called on the object or the marker
        return target_space.first -> return number; computer should mark this space
      end
    end
    nil
  end
--------------------------------------------------------------------------------
  ## thoguht this one was correct but isn't executing

  # def intelligent_play(target_marker)
  #   WINNING_LINES.each do |line|
  #     squares = @squares.values_at(*line)
  #     if two_identical_markers?(squares, target_marker) #-> line has a space we want

  #     target_space = line.select { |key| @squares[key].unmarked? } #not sure if this should be called on the object or the marker
  #       return target_space.first # -> return number; computer should mark this space
  #     end
  #   end
  #   nil
  # end


  # def two_markers
  #   WINNING_LINES.each do |line|
  #     squares = @squares.values_at(*line)
  #     return two_identical_markers(squares)
  #   end
  #   nil
  # end


  #thought this one was correct but it isn't even executing

  # def two_identical_markers?(squares, target_marker) ###this should now work to ID squares with 2 target markers (r=invoke twice)
  #   # binding.pry
  #   markers = squares.select { |square| square.marker == target_marker}.collect(&:marker)
  #   return false if markers.size != 2
  #   markers.min == markers.max
  # end

# thoughts:
#  -iterate over squares, select marked squares


 #functionality:
 # if two_identical_markers?(squares) (there is an at-risk row)
 # =>two_identical_markers(squares) (returns the marker of the first row with 2)

 #   def two_identical_markers(squares) #returning the repeated markers
#     markers = squares.collect(&:marker)
#     if markers.count(Square::INITIAL_MARKER) == 1 && (markers.uniq.size == 2)
#       return markers.max
#     end
#   end
-------------------------------------------------------------------------------
#attempt at implementing offensive play using helper methods and a main move
method from the computer class. Could revisit.


additional thought:
helpers were not working because they were all executing. To mave a "computer move"
method that just lists the helper methods,I need 2 methods for each: 1 to inform the 
if condiiton (middle space is availble, computer has 2 ina row, player has 2 in a row,
else -> sample)

so that would look like: (and the 2 elsif are the same method, with different 
markers as arguments)

def computer_move
  if middle_space_empty?
    choose_middle_space
  elsif two_in_a_word(computer_marker)
    #make offenive move
  elsif two_in_a_row(player_marker)
    #make defensive move
  else
    select_random_square
  end
end
 #def choose_middle_square(board)
  #   board[5] = marker
  # end

  # def choose_winning_square(board, marker)
  
  #   winning_space = board.intelligent_play(marker)
  #     if !!winning_space
  #       binding.pry
  #       board[winning_space] = marker
  #     end
  # end

  #OG def computer_play #(was working)
  # if board.two_markers == marker #### building this out
 #  else
  #     board[board.square_with_missing_marker] = @marker
  #   end
 # end

  # def block_player(board)
  #  at_risk_square = board.intelligent_play(human.marker)
 #   if at_risk_square
  #     board[at_risk_square] = @marker
  #   end
  # end

  # def choose_random_square(board)
  #   board[board.unmarked_keys.sample] = marker
  # end


  # def move(board)
  #   if board.unmarked_keys.include?(5)
  #     board[5] = marker
  #   elsif winning_space = board.intelligent_play(marker)
  #     if !!winning_space
  #       binding.pry
  #       board[winning_space] = marker
  #     end
  #   else
  #   # block_player(board)
  #   choose_random_square(board)
  # end
  # end
------------------------------------------------------------------------------
=end
