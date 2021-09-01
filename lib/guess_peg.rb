# frozen_string_literal: true

module Mastermind
  # pegs that the guesser (ie codebreaker) places in their guess board
  class GuessPeg
    def initialize(color)
      @color = color # Yellow, Blue, Green, Red, Purple, or Orange
    end

    # possible methods: read/write color
    attr_reader :color
  end
end
