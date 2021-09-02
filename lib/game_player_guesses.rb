# frozen_string_literal: true

module Mastermind
  # this contains the logic of the game when the player is guessing the code
  class GamePlayerGuesses < Game
    def play_game_player_guesses
      puts 'Welcome to Mastermind.'
      # decide maker and breaker (right now this is always the same)
      # prompt maker for code
      # collect_maker_code # if the human is codemaker
      computer_generate_code # if the computer is codemaker
      puts 'The Codemaker has selected their code.'
      puts 'Codebreaker, after you submit your guess, you will be shown the feedback board. Each position there corresponds to the matching position on your guess board. A Black means your guess in that position is exactly correct. A White means that number exists in the code but not in that position.'
      puts 'Good luck :)'
      loop_through_turns
      # after 12, if still no win, declare loss
      puts 'Game over.'
      # new game?
    end

    private

    def computer_generate_code
      @code_board.state.map! do
        # check if random_color exists in array to avoid duplicates
        random_color = rand(1..6)
        random_color = rand(1..6) while @code_board.state.include?(random_color.to_s)
        random_color.to_s # convert to strings b/c currently guess board is strings. Needed for feedback engine to work
      end
    end

    def collect_breaker_guess_string
      # prompt breaker for guess
      puts 'Codebreaker, enter your guess as a string of four numbers (1-6). No duplicates or blanks. For example, 1234.'
      guess = gets.chomp
      until guess_string_input_valid?(guess)
        puts "Invalid entry."
        guess = gets.chomp
      end
      guess_array = guess.split('')
      @codebreaker.make_guess(@guess_board, guess_array[0], guess_array[1], guess_array[2], guess_array[3])

      # print state for debugging (may be replaced by display)
      puts "Guess Board: #{@guess_board.state}"
      puts ''
    end

    # rubocop:disable Metrics/MethodLength
    def collect_breaker_guess_chars
      # prompt breaker for guess
      puts 'Codebreaker, place a peg (1-6) in position 1. No duplicates or blanks.'
      color1 = gets.chomp
      puts 'Codebreaker, place a peg (1-6) in position 2. No duplicates or blanks.'
      color2 = gets.chomp
      puts 'Codebreaker, place a peg (1-6) in position 3. No duplicates or blanks.'
      color3 = gets.chomp
      puts 'Codebreaker, place a peg (1-6) in position 4. No duplicates or blanks.'
      color4 = gets.chomp
      @codebreaker.make_guess(@guess_board, color1, color2, color3, color4)

      # print state for debugging (may be replaced by display)
      puts "Guess Board: #{@guess_board.state}"
      puts ''
    end
    # rubocop:enable Metrics/MethodLength

    # rubocop:disable Metrics/MethodLength
    def loop_through_turns
      (1..@round_count).each do |i|
        @feedback_board.reset # reset feedback_board
        collect_breaker_guess_string
        if check_win?
          puts "Code Board: #{@code_board.state}"
          puts 'Codebreaker, you win!'
          break
        end
        if i == 12
          puts "Code Board: #{@code_board.state}"
          puts 'You lose.'
          break
        end
        feedback_engine
      end
    end
    # rubocop:enable Metrics/MethodLength

    def guess_string_input_valid?(string)
      array = string.split('') # to check for duplicate values
      string.length == 4 && string.delete('1-6').empty? && array.uniq == array
    end
  end
end
