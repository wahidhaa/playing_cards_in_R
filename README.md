# playing_cards_in_R

A virtual deck of 52 playing cards and sets it
up for three different card games (War, Hearts, Blackjack), based on
Project 2 of [Hands-On Programming with R](https://rstudio-education.github.io/hopr/project-2-playing-cards.html) by Garrett Grolemund.

## What it does:
1. Builds a base deck as a data frame with 52 rows (one per card) and
   3 columns: face (A, 2-10, J, Q, K), suit (spades, clubs, hearts,
   diamonds), and value (1-13).

2. Creates a customized copy of the deck for each game, since card
   values differ by game:
     - War:       Aces are high, worth 14.
     - Hearts:    Every heart is worth 1 point, the queen of spades
                  is worth 13 points, everything else is worth 0.
     - Blackjack: Face cards (J, Q, K) are worth 10, Aces are set to
                  NA (since they can count as 1 or 11 depending on
                  the hand).

3. Defines a setup() function that packages a deal() and shuffle()
   function together for a given deck, using R's enclosures so each
   game keeps its own independent, persistent copy of its deck
   in memory.

4. Creates deal_war(), shuffle_war(), deal_hearts(), shuffle_hearts(),
   deal_blackjack(), and shuffle_blackjack() functions
   for each game.

## How to run:
1. Source 'playing_cards_script' in R or RStudio.
2. Run the script.
3. Commands:

       shuffle_war()     # resets to a shuffled deck of 52 cards
       deal_war()        # deal the top card
       deal_war()        # deal the next card

       shuffle_hearts()
       deal_hearts()

       shuffle_blackjack()
       deal_blackjack()

Note: Each game's deck is independent -- shuffling or dealing from War has
no effect on the Hearts or Blackjack decks.
