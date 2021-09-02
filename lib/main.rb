# frozen_string_literal: true

require_relative 'guess_peg'
require_relative 'player'
require_relative 'guess_board'
require_relative 'feedback_board'
require_relative 'code_board'
require_relative 'feedback_peg'
require_relative 'game'
require_relative 'game_player_guesses'
require_relative 'game_computer_guesses'

codemaker = Mastermind::Player.new('Computer', 'Codemaker')
codebreaker = Mastermind::Player.new('Human', 'Codebreaker')
code_board = Mastermind::CodeBoard.new
guess_board = Mastermind::GuessBoard.new
feedback_board = Mastermind::FeedbackBoard.new

loop do
  puts 'Player, which would you like to play as?'
  puts '1) Codemaker'
  puts '2) Codebreaker'
  player_selection = gets.chomp
  case player_selection
  when '1'
    puts ''
    a_game = Mastermind::GameComputerGuesses.new(codemaker, codebreaker, code_board, guess_board, feedback_board)
    a_game.play_game
    puts 'New game? (Y/N)'
    new_game_selection = gets.chomp
    if new_game_selection == 'Y'
      next
    else
      break
    end
  when '2'
    puts ''
    a_game = Mastermind::GamePlayerGuesses.new(codemaker, codebreaker, code_board, guess_board, feedback_board)
    a_game.play_game
    puts 'New game? (Y/N)'
    new_game_selection = gets.chomp
    if new_game_selection == 'Y'
      next
    else
      break
    end
  else
    puts 'Invalid selection.'
    puts ''
  end
end
