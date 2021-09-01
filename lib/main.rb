# frozen_string_literal: true

require_relative 'guess_peg'
require_relative 'player'
require_relative 'guess_board'
require_relative 'feedback_board'
require_relative 'code_board'
require_relative 'feedback_peg'
require_relative 'game'

test_guess_board = Mastermind::GuessBoard.new

p test_guess_board.state
