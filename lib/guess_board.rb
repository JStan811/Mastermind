# frozen_string_literal: true

module Mastermind
  # board guesser/codebreaker uses
  class GuessBoard
    def initialize
      @state = Array.new(4) # array of 4 positions, all with a value of a color (or number?) Or should the value be a peg?
    end

    # possible methods: read/write state (read board state / place pegs), reset, display board
    attr_accessor :state

    def reset
      @state = Array.new(4)
    end

    def display_board
      # print user friendly display of board
    end
  end
end
