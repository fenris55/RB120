=begin

Description:

21 is a two-player game played using a standard deck of cards. One person is
the dealer, and the other is the player. Both start with 2 cards. The player
can see both of their own cards and one of the dealers cards. The player can
either continue drawing cards or hold. The goal is to get as close to 21 as
possible without going over. If the player's card total exceeds 21, the player
busts (looses). The dealer will continue drawing cards until they bust or their
total is between 17 and 21. If both player and dealer hold, whoever's card
sum is closest to 21 wins. Aces can be worth 1 or 11 point, depending on what is
most advantageous to the player.

Nouns:
player, dealer, card, deck, hand

Verbs:
deal, hit, stay, bust, win, lose, add, compare

Organized:
Deck
  -deal (cards are dealt and deck is updated)

Hand (module?)
-add (math to sum each player's hand)
-compare (compare the sum of each player's hand)

Player
  @hand (each player has a hand)

  move
Dealer < Player
  # move -> randomly given card from deck; loop until bust or sum >= 17
  hit
  stay
  busted?
  @total

Human < Player
  # move -> prompt human to stay or hit
  hit
  stay
  busted?
  @total

Game
-initialize players and new deck
-play
  -human move
  break if bust or stay
  -dealer move
  break if bust or stay
  -compare
  -announce winner
  -player again?

Spike:

=end

### My Initial attempt:
# module Hand
#   def add_cards# (math to sum each player's hand)
#     #access values of player cards and identify total; include functionality
#     #to adjust for ace if score is over 21 (ace takes a starting score of 11,
#     # so 10 can be substracted for each ace until either score is under 21 or
#     #no aces are left)
#   end

# def compare #(compare the sum of each player's hand)
#   player.total > dealer.total ? player.total : dealer.total
# end
# end

# class Deck
#   attr_accessor :deck

#   def initialize
#     @deck = new_deck
#   end

#   def new_deck
#     deck = []

#     4.times do |_|
#       (2..10).each do |num_card|
#         deck << num_card
#       end
#     end

#     12.times do |_| #faces -> these can acutally all be separate helper methods
#       deck << 10
#     end

#     4.times do |_| #aces
#       deck << 11
#     end
#     #populate @deck hash with 52 cards
#     #actually, none of the suits/faces really need to be documented
#     #2-10 repeat 4 times
#     #10 repeats another 12 times (3 faces x 4 suits) (so total of 26 10s?)
#     #11 repeats 4 times (aces -> can be adjusted to 1)
#     #so, deck can actually just be an array of integers
#     #only benefit of suits is display/extra info
#   end
# end

# class Dealer

#   include Hand

#   attr_accessor :name, :cards, :total

#   def initialize
#     @name = ''
#     @cards =[]
#     @total = 0
#     #player hand does not need ot be documented; can just save the number
#   end

#   ##NOTES: this functionality repeats in player. Would move to superclass but
# # instructions are going to model playing them in the Hand module
#   def hit
#     deal #from Hand module
#   end

#   def stay
#     #if dealer stays, game if over -> calculate total and compare
#   end

#   def busted?
#     total > 21
#   end
# end

# class Player
#   include Hand

#   attr_accessor :name, :cards, :total

#   def initialize
#     @name = ''
#     @cards =[]
#     @total = 0
#   end

# #   hit
# #   stay
# #   busted?
# #   @total
# end

# class Game
#   attr_reader :player, :dealer
#   attr_writer :deck

#   def initialize
#     @player = Player.new
#     @dealer = Dealer.new
#     @deck = Deck.new
#   end

#   def display_welcome_message
#     puts "Welcome to 21!"
#     puts ""
#     puts "You and the dealer will each recieve 2 cards."
#     puts "You can choose to hit or stay."
#     puts ""
#     puts "The goal is to get as close to 21 as possible."
#     puts "If your card total exceeds 21, you'll bust!"
#     puts ""
#     puts "Let's play!"
#   end

#   def opening_deal #(cards are dealt and deck is updated)
#     #assign 2 random cards each to player and dealer; remove from deck
#   end

#   def deal
#     #assign 1 random card and remove from deck
#   end

#   def play
#     display_welcome_message
#     loop do
#       opening_deal
#       human_move
#       break if busted? or stay
#       dealer move
#       break if busted? or stay
#       compare_hands
#       announce_winner
#       break unless player_again?
#     end
#     goodbye_message
#   end
# end

# game = Game.new
# game.play

# LS - provided reference
