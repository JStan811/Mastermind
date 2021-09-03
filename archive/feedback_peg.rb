# frozen_string_literal: true

module Mastermind
  # peg placed in feedback board
  class FeedbackPeg
    def initialize(color)
      @color = color # Black or white - black is perfect, white is right color wrong position
    end

    # possible methods: read/write color
    attr_reader :color
  end
end
