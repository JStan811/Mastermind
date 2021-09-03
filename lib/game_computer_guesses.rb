# frozen_string_literal: true

module Mastermind
  # this contains the logic of a game where computer guesses the code
  class GameComputerGuesses < Game
    def play_game
      puts 'You are the Codemaker. Submit your code and the computer will try to guess it.'
      # user makes code, program saves it into code_board.state
      collect_maker_code_string
      # computer guesses, then game checks win
      puts 'Initial guess:'
      computer_generate_guess
      puts "Guess Board: #{@guess_board.state}"
      puts ''
      if check_win?
        puts 'Computer has guessed correctly. You lose.'
        return
      end
      # computer changes submission up to 12 times (ie @round_count) based on feedback
      # game declares player winner or player loser
      loop_through_turns_computer_guessing
      puts 'Game over.'
      # new game?
    end

    private

    def collect_maker_code_string
      # prompt breaker for guess
      puts "Enter your code as a string of four numbers (1-#{@color_count}). No duplicates or blanks. For example, 1234."
      guess = gets.chomp
      until guess_string_input_valid?(guess)
        puts 'Invalid entry.'
        guess = gets.chomp
      end
      code_array = guess.split('')
      @codebreaker.make_guess(@code_board, code_array[0], code_array[1], code_array[2], code_array[3])

      # print state for debugging (may be replaced by display)
      puts "Guess Board: #{@code_board.state}"
      puts ''
    end

    def computer_guessing_code
      # first random generate 4 numbers (could also just do 1234 every first round, that's what I do)
      computer_generate_guess
      # then keep changing guess based on feedback up to 12(@round_count) times or until the code is right
      # change logic: keep blacks the same, move whites one position to the right, increase nils by 1 (skipping over whites and blacks)
    end

    def computer_generate_guess
      @guess_board.state.map! do
        # check if random_color exists in array to avoid duplicates
        random_color = rand(1..@color_count)
        random_color = rand(1..@color_count) while @guess_board.state.include?(random_color.to_s)
        random_color.to_s # convert to strings b/c currently guess board is strings. Needed for feedback engine to work
      end
    end

    def computer_change_guess_just_black
      @guess_board.state.each_with_index do |num, i|
        if @feedback_board.state[i] == 'Black'
          next
        else
          @guess_board.state[i] = rand(1..@color_count).to_s
        end
      end
    end

    def computer_change_guess
      # look at feedback engine. if there is a black, keep that position the same in the guess board. if white, move the color in that position one to the right skipping over black. if nil, randomize (update this in the future to randomize, skipping blacks and whites)
      # another option for response to white: find first nil, if there are no nils, find first white that isn't self
      # this second option might need an empty array, locked_positions, that you push any i into that shouldn't be touched
      @guess_board.state.each_with_index do |x, i|
        if @feedback_board.state[i] == 'Black'
          next
        elsif @feedback_board.state[i] == 'White'
          @feedback_board.state.each_with_index do |y, j|
            if @feedback_board.state[i + 1] != 'Black'
              @guess_board.state[i + 1] = x
            end
          end
        else
          @guess_board.state[i] = rand(1..@color_count).to_s
        end
      end
    end

    def computer_guess_turn
      feedback_engine
      computer_change_guess_just_black
      puts "Guess Board: #{@guess_board.state}"
    end

    # rubocop:disable Metrics/MethodLength
    def loop_through_turns_computer_guessing
      (1..@round_count).each do |i|
        sleep 3
        @feedback_board.reset
        puts ''
        puts "Round #{i}:"
        computer_guess_turn
        if check_win?
          puts "Code Board: #{@code_board.state}"
          puts 'Computer has guessed correctly. You lose.'
          break
        end
        if i == @round_count
          puts "Code Board: #{@code_board.state}"
          puts 'Computer was not able to guess your code. You win.'
          break
        end
      end
    end
    # rubocop:enable Metrics/MethodLength
  end
end
