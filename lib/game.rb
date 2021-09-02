# frozen_string_literal: true

module Mastermind
  # this contains the logic of the game
  class Game
    def initialize(codemaker, codebreaker, code_board, guess_board, feedback_board)
      @codemaker = codemaker
      @codebreaker = codebreaker
      @code_board = code_board
      @guess_board = guess_board
      @feedback_board = feedback_board
      @round_count = 12
      @color_count = 6
      @duplicates_allowed = false
      @blanks_allowed = false
    end

    # rubocop:disable Layout/LineLength
    # possible methods: handle turn, check and declare winner/loser, keep score, feedback engine (decide feedback, set feedback, display feedback), play game (prompt maker for code -> prompt breaker for guess -> collect guess -> run feedback engine -> check for winner. if none, continue -> if after 12th round no win, declare loser -> new game?)
    # rubocop:enable Layout/LineLength

    private

    def check_win?
      # evaluate guess board - does guess == code?
      # if yes, return true
      @guess_board.state == @code_board.state
    end

    def feedback_engine
      # compare guess board and code board
      # loop through guess board and check each position with corresponding position of code board, noting which are the same and updating feedback board
      # then loop through guess board, checking if color exists anywhere in code board and updating feedback board
      @guess_board.state.each_with_index do |guess_color, index|
        @code_board.state.each do |code_color|
          @feedback_board.state[index] = 'White' if guess_color == code_color # should replace = 'White' with place_peg method
        end

        @feedback_board.state[index] = 'Black' if guess_color == @code_board.state[index] # should replace = 'Black' with place_peg method
      end

      # print state for debugging (may be replaced by display)
      puts "Feedback Board: #{@feedback_board.state}"
      puts ''
    end

    def guess_string_input_valid?(string)
      array = string.split('') # to check for duplicate values
      string.length == 4 && string.delete("1-#{@color_count}").empty? && array.uniq == array
    end
  end
end
