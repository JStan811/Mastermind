# frozen_string_literal: true

require_relative 'guess_peg'
require_relative 'player'
require_relative 'guess_board'
require_relative 'feedback_board'
require_relative 'feedback_peg'
require_relative 'game'

peg1 = Mastermind::GuessPeg.new

peg1.color = 'red'

p peg1.color
