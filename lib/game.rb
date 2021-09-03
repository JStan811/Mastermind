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

    private

    def check_win?
      @guess_board.state == @code_board.state
    end

    def feedback_engine
      @guess_board.state.each_with_index do |guess_color, index|
        @code_board.state.each do |code_color|
          @feedback_board.state[index] = 'White' if guess_color == code_color
        end

        @feedback_board.state[index] = 'Black' if guess_color == @code_board.state[index]
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
