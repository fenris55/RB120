#Tic Tac Toe Game with Bonus Features

module Displayable
  def display_welcome_message
    puts "Welcome to Tic Tac Toe!"
    puts "First player to win 5 rounds is the Grand Winner!"
    puts ""
  end

  def display_board
    puts "#{human.name} is an #{human.marker}. #{computer.name} is an #{computer.marker}."
    puts ""
    board.draw
    puts ""
  end

  def display_result
    display_board

    case board.winning_marker
    when human.marker
      puts "#{human.name} won!"
    when computer.marker
      puts "#{computer.name} won!"
    else
      puts "It's a tie!"
    end
  end

  def display_score
    puts "Current score is: #{human.name}: #{human.score}, #{computer.name}: #{computer.score}."
  end

  def display_play_again_message
    puts "Let's play again!"
    puts ''
  end

  def display_grandwinner
     if human.score == 5
      puts ""
      puts "*** #{human.name} is the Grand Winner! ***"
      puts ""
    elsif computer.score == 5
      puts ""
      puts "***#{computer.name} is the Grand Winner!***"
      puts ""
    end
  end

  def display_goodbye_message
    puts "Thanks for playing, #{human.name}! Goodbye!"
  end

end

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

  def joinor
    empty_squares = self.unmarked_keys

    if empty_squares.size == 1
      empty_squares.join
    elsif empty_squares.size == 2
       empty_squares.first.to_s + ' or ' + empty_squares.last.to_s
    else
      empty_squares[-1] = "or #{empty_squares[-1].to_s}"
      empty_squares.join(', ')
    end
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

  def missing_marker?
    WINNING_LINES.each do |line|
      squares = @squares.values_at(*line)
      return true if two_identical_markers?(squares)
    end
    nil
  end

  def square_with_missing_marker
    WINNING_LINES.each do |line|
      squares = @squares.values_at(*line)
      if two_identical_markers?(squares)
        return line[0] if @squares[line[0]].unmarked?
        return line[1] if @squares[line[1]].unmarked?
        return line[2] if @squares[line[2]].unmarked?
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

  def two_identical_markers?(squares)
    markers = squares.collect(&:marker)
    if markers.count(Square::INITIAL_MARKER) == 1 && (markers.uniq.size == 2)
      return true
    end
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
  attr_accessor :marker, :name, :score

  def initialize
    @marker = ''
    @name = ''
    @score = 0
  end
end

class Human < Player
  def initialize
    super
  end

  def pick_name
    name = nil
    loop do
      puts "Please enter your name:"
      name = gets.chomp.capitalize
      break if !name.strip.empty?
      puts "That's not a valid entry"
    end
    @name = name
  end

  def pick_marker
    choice = nil

    loop do
      puts "Choose your marker: X or O"
      choice = gets.chomp.upcase
      break if %w(X O).include? choice
      puts "That's not a valid entry. Try again."
    end

    @marker = choice
  end

  def move(board)
    puts "Choose a square: #{board.joinor}"
    square = nil
    loop do
      square = gets.chomp.to_i
      break if board.unmarked_keys.include?(square)
      puts "Sorry, that's not a valid choice."
    end
    board[square] = marker
  end
end

class Computer < Player

  def initialize
    super
  end

  def pick_name
    names = %w(Fred Bob R2D2 Bumblebee)
    @name = names.sample
  end

  def pick_marker(other_marker)
    other_marker == 'X' ? @marker = 'O' : @marker = "X"
  end

  # last task: expand elsif so computer makes offensive and then defensive moves
  def move(board)
    if board.unmarked_keys.include?(5)
      board[5] = marker
    elsif board.missing_marker?
      board[board.square_with_missing_marker] = marker
    else
      board[board.unmarked_keys.sample] = marker
    end
  end
end

class TTTGame
  include Displayable

  attr_reader :board, :human, :computer
  attr_accessor :computer, :current_marker

  def initialize
    @board = Board.new
    @human = Human.new
    @computer = Computer.new
    @current_marker = ''
  end

  def play
    clear
    display_welcome_and_get_names
    main_game
    display_goodbye_message
  end

  private

  def display_welcome_and_get_names
    display_welcome_message
    pick_names
  end

  def clear
    system 'clear'
  end

  def main_game
    loop do
      set_up_game
      display_board
      player_move
      display_result
      update_score
      break unless play_again?
      reset
      display_play_again_message
    end
  end

  def set_up_game
    pick_markers
    assign_first_to_move
  end

  def pick_names
    human.pick_name
    computer.pick_name
  end

  def pick_markers
    human.pick_marker
    computer.pick_marker(human.marker)
  end

  def assign_first_to_move
    self.current_marker = human.marker
  end

  def player_move
    loop do
      current_player_moves
      break if board.someone_won? || board.full?
      clear_screen_and_display_board if human_turn?
    end
  end

  def human_turn?
    @current_marker == human.marker
  end

  def current_player_moves
    if human_turn?
      human.move(board)
      @current_marker = computer.marker
    else
      computer.move(board)
      @current_marker = human.marker
    end
  end

  def update_score
    increment_score
    display_score
    grandwinner
  end

  def increment_score
    if board.winning_marker == human.marker
      human.score += 1
    elsif board.winning_marker == computer.marker
      computer.score += 1
    end
  end

  def reset_scores
    if human.score == 5 || computer.score == 5
      human.score = 0
      computer.score = 0
    end
  end

  def grandwinner
    display_grandwinner
    reset_scores
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

  def clear_screen_and_display_board
    clear
    display_board
  end

  def reset
    board.reset
    @current_marker = human.marker
    clear
  end
end

game = TTTGame.new
game.play
