# frozen_string_literal: true

require_relative 'player'
require_relative 'board'
require_relative 'game'
require_relative 'game_player_guesses'
require_relative 'game_computer_guesses'
require_relative 'game_master'

codemaker = Mastermind::Player.new('Computer', 'Codemaker')
codebreaker = Mastermind::Player.new('Human', 'Codebreaker')
code_board = Mastermind::Board.new('code')
guess_board = Mastermind::Board.new('guess')
feedback_board = Mastermind::Board.new('feedback')
game_computer_guesses = Mastermind::GameComputerGuesses.new(codemaker, codebreaker, code_board, guess_board, feedback_board)
game_player_guesses = Mastermind::GamePlayerGuesses.new(codemaker, codebreaker, code_board, guess_board, feedback_board)
game_master = Mastermind::GameMaster.new(game_player_guesses, game_computer_guesses)

game_master.game_loop
