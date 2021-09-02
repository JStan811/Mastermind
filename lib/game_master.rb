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
        player_selection = solicit_player_role_choice
        case player_selection
        when '1'
          play_game(@game_computer_guesses)
          next if solicit_new_game_choice == 'Y'
          break
        when '2'
          play_game(@game_player_guesses)
          next if solicit_new_game_choice == 'Y'
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
    end

    def solicit_player_role_choice
      puts 'Player, which would you like to play as?'
      puts '1) Codemaker'
      puts '2) Codebreaker'
      gets.chomp
    end

    def play_game(game)
      puts ''
      game.play_game
    end

    def solicit_new_game_choice
      puts 'New game? (Y/N)'
      gets.chomp
    end
  end
end
