# frozen_string_literal: true

module Mastermind
  # player can be human or computer, also codemaker or codebreaker
  class Player
    def initialize(user_type, game_type)
      @user_type = user_type # human or computer
      @game_type = game_type # codemaker or codebreaker
    end

    # possible methods: place peg(s), submit guess, change guess, submit/make code
    def make_code(code_board, color1, color2, color3, color4)
      place_peg(code_board, 0, color1)
      place_peg(code_board, 1, color2)
      place_peg(code_board, 2, color3)
      place_peg(code_board, 3, color4)
    end

    def make_guess(guess_board, color1, color2, color3, color4)
      place_peg(guess_board, 0, color1)
      place_peg(guess_board, 1, color2)
      place_peg(guess_board, 2, color3)
      place_peg(guess_board, 3, color4)
    end

    # for change guess method, "For position 1, type new color or press Enter to keep same color"

    private

    def place_peg(board, board_position, color)
      board.state[board_position] = color
    end
  end
end
