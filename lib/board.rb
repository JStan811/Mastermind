# frozen_string_literal: true

module Mastermind
  # board in which feedback pegs are placed
  class Board
    def initialize(type)
      @type = type # guess, code, or feedback
      @state = Array.new(4)
    end

    attr_accessor :state

    def reset
      @state = Array.new(4)
    end
  end
end
