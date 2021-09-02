# frozen_string_literal: true

module Mastermind
  # board in which feedback pegs are placed
  class Board
    def initialize(type)
      @type = type # guess, code, or feedback
      @state = Array.new(4) # array of 4 positions, all with a value of a number (if code board or guess board) or color (if feedback board). Or should the value be a peg (or lack thereof)?
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
