require 'pry'

######################## CARD  ##############################

class Card
  attr_accessor :suit,  :face_value

  def initialize (s, fv)
    @suit = s
    @face_value = fv
  end


  def pretty_output
     "The face #{@suit}  of #{@face_value}"
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

  def   scramble!
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

  end

  def show_hands
    p "******* #{name} cards are in total: *******  "

    _cards.each do |card|
      p "=> #{card}"
    end

    p '****************************************'
    p "==> Total: #{calculating_the_total}"
  end



  def calculating_the_total
    # [['H', '3'], ['S', 'Q'], ... ]
    face_value = _cards.map { |card| card.face_value }

    total = 0
    face_value.each do |value|
      if value == "A"
        total += 11
      elsif value.to_i == 0 # J, Q, K
        total += 10
      else
        total += value.to_i
      end
    end

    #correct for Aces
    face_value.select{|e| e == "A"}.count.times do
      total -= 10 if total > 21
    end

    total

  end


  def getting_a_hand (_2_cards)
    _cards << _2_cards
  end


  def showing_last_item
    "You have: #{ _cards[0] } and #{ _cards[1] }"
  end

  def player_loses?
    if calculating_the_total > 21
      return true
    end
  end

  def testing
    puts "its working #{ name }"
  end

end


###################### PLAYER  ################################

class Player
  include Hand
  attr_accessor :_cards, :name

  def initialize (n)
    # @person
    @_cards = []
    @name = n

  end

  def show_flop
    _cards[1]

  end

end

###################### DEALER   ################################

class Dealer
  include Hand
  attr_accessor :_cards, :name
  def initialize
    @_cards = []
    @name = 'Dealer'
  end

  def  show_flop
    p "******* #{name} cards are in total: *******  "

    p "First card is hidden"
    p "=> Second card is:"
    p " #{ _cards[1] }"
  end



end

######################  BLACKJACK engine ################################

class Blackjack_engine
  attr_accessor :player, :dealer, :deck
  def initialize
    @deck = Deck.new
    @player = Player.new('player1')
    @dealer = Dealer.new
  end

  def set_player_names
    puts 'What s\' your name?'
    player.name = gets.chomp
  end

  def deal_cards
    player.getting_a_hand(deck.deal_one)
    dealer.getting_a_hand(deck.deal_one)
    player.getting_a_hand(deck.deal_one)
    dealer.getting_a_hand(deck.deal_one)
  end

  def show_hands
    player.show_hands
    dealer.show_flop

  end

  def blackjack_or_game_over?(player_or_dealer)
    #binding.pry
    if player_or_dealer.calculating_the_total == 21
      if player_or_dealer.is_a?(Dealer)
        p "Sorry, dealer hit blackjack. #{player.name} loses"
      else
        p puts "Congratulations, you hit blackjack! You win!"
      end
    elsif player_or_dealer.player_loses?
      if player_or_dealer.is_a?(Dealer)
        p "Congratulation, Dealer busted. #{player.name} win"
      else
        p "Sorry, #{player.name} busted."
      end
      exit # We finish the app
    end
  end

  def player_turn
    p "#{player.name}'s turn"

    blackjack_or_game_over?(player)

    while !player.player_loses?
      p "What would you like to do? 1) hit or 2) stay"

      response = gets.chomp

      if !['1', '2'].include?(response)
        puts "Error: you must enter 1 or 2"
        next
      end
      case response
        when '1'
          p "#{player.name} choose to stay."
          break
        when '2'
          new_cards = deck.deal_one
          p "Dealing card to #{player.name}:"
          "#{new_cards}"
          player.getting_a_hand(new_cards)
          player_total = player.calculating_the_total

          p "Your total is now #{player_total}"

          blackjack_or_game_over?(@player)


      end
    end

  end

  def dealer_turn

    p "Dealers's turn"
    
    blackjack_or_game_over?(dealer)
    while dealer.calculating_the_total < 17
      new_card = deck.deal_one
      puts "Dealing card to dealer:"
      p "#{new_card}"
      @dealer.getting_a_hand(new_card)
      p "Dealer total is now: #{@dealer.calculating_the_total}"

      blackjack_or_game_over?(dealer)

    end
      p "Dealer stays at #{@dealer.calculating_the_total}"
  end


  def who_won?
    if @player.calculating_the_total > @dealer.calculating_the_total
      p "Congratulations, #{@player.name} wins."
    elsif @player.calculating_the_total < @dealer.calculating_the_total
      " Sorry, #{@player.name} loses."
    else
      p  "Even maybe? :)"
    end
    exit
  end

  def game_on
    set_player_names
    deal_cards

    show_hands
    player_turn
    dealer_turn
    who_won?

  end
end

game = Blackjack_engine.new
game.game_on






