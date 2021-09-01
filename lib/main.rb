# frozen_string_literal: true

require_relative 'guess_peg'
require_relative 'player'
require_relative 'guess_board'
require_relative 'feedback_board'
require_relative 'code_board'
require_relative 'feedback_peg'
require_relative 'game'

codemaker = Mastermind::Player.new('Computer', 'Codemaker')
codebreaker = Mastermind::Player.new('Human', 'Codebreaker')
code_board = Mastermind::CodeBoard.new
guess_board = Mastermind::GuessBoard.new
feedback_board = Mastermind::FeedbackBoard.new

a_game = Mastermind::Game.new(codemaker, codebreaker, code_board, guess_board, feedback_board)

a_game.play_game
