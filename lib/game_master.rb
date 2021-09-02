# frozen_string_literal: true

module Mastermind
  # this class is used to control the game loop
  class GameMaster
    def initialize(game_player_guesses, game_computer_guesses)
      @game_player_guesses = game_player_guesses
      @game_computer_guesses = game_computer_guesses
    end

    # game loop
    def game_loop
      loop do
        welcome_message
        player_selection = gets.chomp
        case player_selection
        when '1'
          play_game_then_new_game_message(@game_computer_guesses)
          new_game_selection = gets.chomp
          next if new_game_selection == 'Y'
          break
        when '2'
          play_game_then_new_game_message(@game_player_guesses)
          new_game_selection = gets.chomp
          next if new_game_selection == 'Y'
          break
        else
          puts 'Invalid selection.'
          puts ''
        end
      end
    end

    private

    def welcome_message
      puts 'Welcome to Mastermind'
      puts ''
      puts 'Player, which would you like to play as?'
      puts '1) Codemaker'
      puts '2) Codebreaker'
    end

    def play_game_then_new_game_message(game)
      puts ''
      game.play_game
      puts 'New game? (Y/N)'
    end
  end
end
