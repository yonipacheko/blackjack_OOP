require 'pry'

######################## CARD  ##############################

class Card
  attr_accessor :suit,  :face_value

  def initialize (s, fv)
    @suit = s
    @face_value = fv
  end


  def pretty_output
    puts "The face #{@suit}  of #{@face_value}"
  end

  def to_s       #formating the object
    pretty_output
  end

end

########################  DECK  ##############################

class Deck
  attr_accessor :cards

  def initialize
    @cards = []
    ['H', 'D', 'S', 'C'].each do |suit|

      ['2', '3', '4', '5', '6', '7', '8', '9', '10', 'J', 'Q', 'K', 'A'].each do |face_value|

        @cards << Card.new(suit, face_value)
      end
    end
    #shuffling deck
    scramble!
  end # ends initialize

  def  scramble!
    cards.shuffle!
  end
  def deal_one
    cards.pop
  end

end

######################  HAND  ################################

# it should work like abstract class or something similar

module Hand


  def initialize
    @deck = Deck.new
  end

  def getting_one_hand
    player_cards << @deck.deal_one
  end

  #binding.pry
  def showing_last_item
    "You have: #{player_cards[0]} and #{player_cards[1]}"
  end
end

###################### PLAYER  ################################

class Player
  include Hand
  attr_accessor :player_cards

  def initialize (n)
    # @person
    @player_cards = []
    @name = n
  end

end

###################### DEALER   ################################

class Dealer
  include Hand
  attr_accessor :dealer_cards
  def initialize
    @dealer_cards = []
  end

end

######################  BLACKJACK ################################

player1 = Player.new('fer')
player1.getting_one_hand
player1.showing_last_item

# running the app
=begin

class BlackJack

  def initialize
    @deck = Deck.new
    @player = Player.new
    @dealer = Dealer.new
  end

  def game_On
    lets_start
    showing_cards
    #p 'It \'s working'
  end

  def lets_start
    @deck.scramble!
  end

  def showing_cards
    @player.getting_one_hand
    @player.showing_last_item
    #@dealer.getting_one_hand
    #@dealer.showing_last_item

  end

  def calculate_total (obj)



    # [['H', '3'], ['S', 'Q'], ... ]
    arr = cards.map{|e| e[1] }

    total = 0
    arr.each do |value|
      if value == "A"
        total += 11
      elsif value.to_i == 0 # J, Q, K
        total += 10
      else
        total += value.to_i
      end
    end

    #correct for Aces
    arr.select{|e| e == "A"}.count.times do
      total -= 10 if total > 21
    end

    total



  end

end
=end

# It's not posssible to do this:  puts deck.cards.pretty_output (inheritance)


=begin
class Computer
  @@users = {}
  def initialize (username, password)
    @username = username
    @password = password
    @files = {}
    @@users[username] = password
  end

  def create (filename)
    time= Time.now
    files[filename] = time

    puts 'A new file has created: '

  end

  def Computer.get_users
    @@users
  end
end

my_computer = Computer.new('fer', 123)

=end
