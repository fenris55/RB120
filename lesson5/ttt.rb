=begin

Description:
tic tac toe is a 2-player game played on a 3x3 grid. Players take turns placing
either X or O onto grid. First player  to place 3 pieces in a row (vertical,
diagnonal, or horizontal) is the winner.

nouns:
player, board/grid, square, piece (x or o) -> board, player, square, grid

verbs:
move/place, win -> play, mark

Outline:

Board
  -Square

Player
  - def play
  - def mark
-------------------------------------------------------------------------------
Spike: My initial outline/spike

class Board
  attr_accessor :board

  # need a hash to hold the 9 squares and record player moves on those squares
  sqaures = {square1: '', square2: '', square3: '', square4: '', square5: ''
  square6: '', square7: '', square8: '', square9: '' }

  def display_board
    set up game board using puts, - and | chars, interpolation of hash values
  end
end

class Square < Board
end

class Player
  attr_accessor :name, :piece

  def initialize
    set_name
    set_piece
  end

  def mark
    # link to sqaure?? -> display hash keys with empty string values (available
    square); prompt user to chose a number; save player's piece to hash value

    # polymorphic -> separate human and player mark methods (computer will need
    to randomly choose from availble squares)
  end
end

class Human < Player
  def set_name
    # prompt user for name, validate, save to @name
  end

  def set_piece
    # prompt user to select X or O from an array; save at @piece
  end
end

class Computer < Player

  def set_name
    # set up array of names and randomly select one, save to @name
  end

  def set_piece
    if player's piece is o, set to x; if player's piece is x, set to o
  end
end

def Game
  attr_accessor: board, human, computer

  def initialize
    @board = Board.new
    @human = Human.new
    @computer = Computer.new
  end

  def greeting
  end

  def goodbye
  end

  def play_again?
  end

  def determine_winner
  end

  def play
    greeting
    set name
    set piece

    loop do
      human moves
      compuer moves
      display board
      determine winner
      break if play again?
    end

    goodbye
  end
end

game = Game.new
game.play
-------------------------------------------------------------------------------
Outline provided by LS for spike videos:

=end

class Board
  WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9]] +
                  [[1, 4, 7], [2, 5, 8], [3, 6, 9]] +
                  [[1, 5, 9], [3, 5, 7]]

  def initialize
    @squares = {}
    reset
  end

  def []=(key, marker)
    @squares[key].marker = marker
  end

  def unmarked_keys
    @squares.keys.select { |key| @squares[key].unmarked? }
  end

  def full?
    unmarked_keys.empty?
  end

  def someone_won?
    !!winning_marker
  end

  def winning_marker
    WINNING_LINES.each do |line|
      squares = @squares.values_at(*line)
      if three_identical_markers?(squares)
        return squares.first.marker
      end
    end
    nil
  end

  def reset
    (1..9).each { |key| @squares[key] = Square.new }
  end

  # rubocop:disable Metrics/AbcSize
  # rubocop:disable Metrics/MethodLength
  def draw
    puts "     |     |"
    puts "  #{@squares[1]}  |  #{@squares[2]}  |  #{@squares[3]}"
    puts "     |     |"
    puts "-----+-----+-----"
    puts "     |     |"
    puts "  #{@squares[4]}  |  #{@squares[5]}  |  #{@squares[6]}"
    puts "     |     |"
    puts "-----+-----+-----"
    puts "     |     |"
    puts "  #{@squares[7]}  |  #{@squares[8]}  |  #{@squares[9]}"
    puts "     |     |"
  end
  # rubocop:enable Metrics/AbcSize
  # rubocop:enable Metrics/MethodLength

  private

  def three_identical_markers?(squares)
    markers = squares.select(&:marked?).collect(&:marker)
    return false if markers.size != 3
    markers.min == markers.max
  end
end

class Square
  INITIAL_MARKER = " "

  attr_accessor :marker

  def initialize(marker=INITIAL_MARKER)
    @marker = marker
  end

  def to_s
    @marker
  end

  def unmarked?
    marker == INITIAL_MARKER
  end

  def marked?
    marker != INITIAL_MARKER
  end
end

class Player
  attr_reader :marker

  def initialize(marker)
    @marker = marker
  end
end

class TTTGame
  HUMAN_MARKER = 'X'
  COMPUTER_MARKER = 'O'
  FIRST_TO_MOVE = HUMAN_MARKER

  attr_reader :board, :human, :computer, :current_marker

  def initialize
    @board = Board.new
    @human = Player.new(HUMAN_MARKER)
    @computer = Player.new(COMPUTER_MARKER)
    @current_marker = FIRST_TO_MOVE
  end

  def play
    clear
    display_welcome_message
    main_game
    display_goodbye_message
  end

  private

  def display_welcome_message
    puts "Welcome to Tic Tac Toe!"
    puts ""
  end

  def clear
    system 'clear'
  end

  def main_game
    loop do
      display_board
      player_move
      display_result
      break unless play_again?
      reset
      display_play_again_message
    end
  end

  def human_moves
    puts "Choose a square: #{board.unmarked_keys.join(', ')}"
    square = nil
    loop do
      square = gets.chomp.to_i
      break if board.unmarked_keys.include?(square)
      puts "Sorry, that's not a valid choice."
    end
    board[square] = human.marker
  end

  def computer_moves
    board[board.unmarked_keys.sample] = computer.marker
  end

  def player_move
    loop do
      current_player_moves
      break if board.someone_won? || board.full?
      clear_screen_and_display_board if human_turn?
    end
  end

  def human_turn?
    @current_marker == HUMAN_MARKER
  end

  def current_player_moves
    if human_turn?
      human_moves
      @current_marker = COMPUTER_MARKER
    else
      computer_moves
      @current_marker = HUMAN_MARKER
    end
  end

  def display_result
    display_board

    case board.winning_marker
    when human.marker
      puts "You won!"
    when computer.marker
      puts "The computer won!"
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
      puts "Sorry, you must enter y or n."
    end

    answer == 'y'
  end

  def display_goodbye_message
    puts "Thanks for playing. Goodbye!"
  end

  def display_board
    puts "You're an #{human.marker}. Computer is an #{computer.marker}."
    puts ""
    board.draw
    puts ""
  end

  def clear_screen_and_display_board
    clear
    display_board
  end

  def reset
    board.reset
    @current_marker = FIRST_TO_MOVE
    clear
  end

  def display_play_again_message
    puts "Let's play again!"
    puts ''
  end
end

game = TTTGame.new
game.play
