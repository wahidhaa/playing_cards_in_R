# Playing Cards in R
# Based on "Hands-On Programming with R" (Garrett Grolemund)
# Project 2: https://rstudio-education.github.io/hopr/project-2-playing-cards.html

# Builds a virtual deck of playing cards as a data frame, then
# creates game-specific decks (War, Hearts, Blackjack) with the
# correct card values for each game, plus shuffle/deal functions.

# 1. Build the base deck

# deck is a data frame with 3 variables (face, suit, value)
# and 52 observations (one row per card).

deck <- data.frame(
  face = c("A", "2", "3", "4", "5", "6", "7", "8", "9", "10", "J", "Q", "K",
           "A", "2", "3", "4", "5", "6", "7", "8", "9", "10", "J", "Q", "K",
           "A", "2", "3", "4", "5", "6", "7", "8", "9", "10", "J", "Q", "K",
           "A", "2", "3", "4", "5", "6", "7", "8", "9", "10", "J", "Q", "K"),
  suit = c(rep("spades",   13),
           rep("clubs",    13),
           rep("hearts",   13),
           rep("diamonds", 13)),
  value = rep(1:13, times = 4),
  stringsAsFactors = FALSE
)

# 2. WAR

# In War, Aces are the highest card, so they get a value of 14.

war_deck <- deck  # copy of deck used to play War

war_deck$value[war_deck$face == "A"] <- 14

# 3. HEARTS

# In Hearts, every heart card is worth 1 point, the queen of
# spades is worth 13 points, and everything else is worth 0.

hearts_deck <- deck  # copy of deck used to play Hearts

hearts_deck$value[hearts_deck$suit == "hearts"] <- 1
hearts_deck$value[hearts_deck$suit != "hearts"] <- 0
hearts_deck$value[hearts_deck$face == "Q" & hearts_deck$suit == "spades"] <- 13

# 4. BLACKJACK

# In Blackjack, face cards (J, Q, K) are worth 10 points, and
# Aces are worth either 1 or 11 depending on the hand, so they
# are marked NA here to be handled specially during play.

blackjack_deck <- deck  # copy of deck used to play Blackjack

blackjack_deck$value[blackjack_deck$face %in% c("J", "Q", "K")] <- 10
blackjack_deck$value[blackjack_deck$face == "A"] <- NA

# 5. Shuffling and dealing cards

# setup() encloses a deal() and shuffle() function pair around
# whatever deck is passed in, so each game gets its own private,
# independent deck that persists between calls.

setup <- function(deck) {
  
  DECK <- deck  # a permanent reference copy of the original deck
  
  DEAL <- function() {
    card <- deck[1, ]                                  
    assign("deck", deck[-1, ],                          
           envir = parent.env(environment()))           
    card                                                 
    card
  }
  
  SHUFFLE <- function() {
    random <- sample(1:52, size = 52)                    
    assign("deck", DECK[random, ],                        
           envir = parent.env(environment()))            
  }
  
  list(deal = DEAL, shuffle = SHUFFLE)
}

# 6. Create an independent, enclosed environment per game

# Calling setup() once per game deck gives each game its own
# private "deck" variable that deal/shuffle operate on.

war       <- setup(war_deck)
hearts    <- setup(hearts_deck)
blackjack <- setup(blackjack_deck)

deal_war    <- war$deal        # deals a card from the war deck
shuffle_war <- war$shuffle     # shuffles the war deck

deal_hearts    <- hearts$deal        # deals a card from the hearts deck
shuffle_hearts <- hearts$shuffle     # shuffles the hearts deck

deal_blackjack    <- blackjack$deal        # deals a card from the blackjack deck
shuffle_blackjack <- blackjack$shuffle     # shuffles the blackjack deck

# To play: shuffle each deck once at the start of the game,
# then deal cards as needed. For example:

#   shuffle_war()
#   deal_war()
#   deal_war()