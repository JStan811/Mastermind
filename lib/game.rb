# frozen_string_literal: true

module Mastermind
  # this contains the logic of the game
  class Game
    def initialize
      @codemaker = nil
      @codebreaker = nil
      @round_count = 12
      @color_count = 6
      @duplicates_allowed = false
      @blanks_allowed = false
    end

    # rubocop:disable Layout/LineLength
    # possible methods: handle turn, check and declare winner/loser, keep score, feedback engine (decide feedback, set feedback, display feedback), play game (prompt maker for code -> prompt breaker for guess -> collect guess -> run feedback engine -> check for winner. if none, continue -> if after 12th round no win, declare loser -> new game?)
    # rubocop:enable Layout/LineLength
  end
end
