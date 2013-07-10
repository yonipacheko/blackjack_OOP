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
  binding.pry
  def del_one
   p cards.pop
  end

end

######################  HAND  ################################

# it should work like abstract class or something

class Hand

  def initialize
    @deck = Deck.new
  end


  def asking_4_a_hand
      @deck.del_one
  end
end

###################### PLAYER  ################################

class Player
  attr_accessor :my_cards

  def initialize

    #@person
    @hand = Hand.new
    @my_cards = []
  end
   binding.pry

  def getting_one_hand
    @my_cards << @hand.asking_4_a_hand
  end

  def showing_last_item
    puts "You have: #{my_cards[0]} and #{my_cards[1]}"
  end

end

###################### DEALER   ################################

class Dealer
    attr_accessor :dealer_cards
  def initialize
    @hand = Hand.new
    @dealer_cards = []
  end

  def getting_one_hand
    @dealer_cards << @hand.asking_4_a_hand

  end

  def showing_last_item
    puts "You have: #{dealer_cards[0]} and #{dealer_cards[1]}"
  end
end

######################  BLACKJACK ################################


# running the app

class BlackJack

  def initialize
    @deck = Deck.new
    @player = Player.new
    @dealer = Dealer.new
  end

  def gameOn
    lets_start
    showing_cards
    #p 'It \'s working'
  end

  def lets_start
    @deck.scramble!
  end

  def showing_cards
    @player.showing_last_item
    @dealer.showing_last_item

  end

  def calculate_total (obj)

=begin

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
=end


  end

end

 my_game = BlackJack.new

my_game.gameOn

# It's not posssible to do this:  puts deck.cards.pretty_output (inheritance)