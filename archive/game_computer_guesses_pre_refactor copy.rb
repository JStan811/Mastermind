# frozen_string_literal: true

module Mastermind
  # this contains the logic of a game where computer guesses the code
  class GameComputerGuesses < Game
    def play_game
      puts 'You are the Codemaker. Submit your code and the computer will try to guess it.'
      # user makes code, program saves it into code_board.state
      collect_maker_code_string
      # computer_generate_code
      # puts "Code Board: #{@code_board.state}"
      # computer guesses, then game checks win
      puts 'Initial guess:'
      computer_generate_guess
      # @guess_board.state = ['2', '5', '1', '4'] # hardcode for testing purposes
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
      puts "Code Board: #{@code_board.state}"
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

    # rubocop:disable Metrics/MethodLength
    # rubocop:disable Metrics/AbcSize
    def computer_change_guess
      # steps: look at feedback engine. if there is a black, keep that position the same in the guess board. if white, move the color in that position one to the right skipping over black. if nil, randomize (update this in the future to randomize, skipping blacks and whites)
      # another option for response to white: find first nil, if there are no nils, find first white that isn't self
      # this second option might need an empty array, locked_positions, that you push any i into that shouldn't be touched
      changed_board = @guess_board.state
      @guess_board.state.each_with_index do |x, i|
        if @feedback_board.state[i] == 'Black'
          changed_board[i] = x
          next
        elsif @feedback_board.state[i] == 'White'
          @feedback_board.state.each_with_index do |y, j|
            if y == nil
              changed_board[j] = x
              changed_board[i] = nil
              @feedback_board.state[j] = 1
              break
            end
            if y == 'White' && j != i
              changed_board[j] = x
              changed_board[i] = nil
              @feedback_board.state[j] = 1
              break
            end
          end
        else
          loop do
            random_num = rand(1..@color_count).to_s
            if !(changed_board.include?(random_num))
              changed_board[i] = random_num
              break
            end
          end
          @feedback_board.state[i] = 1
        end
      end
      changed_board.each_with_index do |z, k|
        if z == nil
          loop do
            random_num = rand(1..@color_count).to_s
            if !(changed_board.include?(random_num)) && !(@guess_board.state.include?(random_num))
              changed_board[k] = random_num
              break
            end
          end
        end
      end
      @guess_board.state = changed_board
    end
    # rubocop:enable Metrics/AbcSize
    # rubocop:enable Metrics/MethodLength

    def computer_guess_turn
      feedback_engine
      computer_change_guess
      puts "Guess Board: #{@guess_board.state}"
    end

    # rubocop:disable Metrics/MethodLength
    def loop_through_turns_computer_guessing
      (1..@round_count).each do |i|
        sleep 2
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

    def computer_generate_code
      @code_board.state.map! do
        # check if random_color exists in array to avoid duplicates
        random_color = rand(1..@color_count)
        random_color = rand(1..@color_count) while @code_board.state.include?(random_color.to_s)
        random_color.to_s # convert to strings b/c currently guess board is strings. Needed for feedback engine to work
      end
    end

    # rubocop:disable Metrics/MethodLength
    # rubocop:disable Metrics/AbcSize
    def computer_change_guess_debug
      # steps: look at feedback engine. if there is a black, keep that position the same in the guess board. if white, move the color in that position one to the right skipping over black. if nil, randomize (update this in the future to randomize, skipping blacks and whites)
      # another option for response to white: find first nil, if there are no nils, find first white that isn't self
      # this second option might need an empty array, locked_positions, that you push any i into that shouldn't be touched
      changed_board = @guess_board.state
      @guess_board.state.each_with_index do |x, i|
        if @feedback_board.state[i] == 'Black'
          changed_board[i] = x
          puts "CB: #{changed_board}"
          next
        elsif @feedback_board.state[i] == 'White'
          @feedback_board.state.each_with_index do |y, j|
            if y == nil
              changed_board[j] = x
              changed_board[i] = nil
              p "inr_nil_change"
              puts "CB: #{changed_board}"
              @feedback_board.state[j] = 1
              p @feedback_board.state
              p "inr_nil_break"
              break
            end
            if y == 'White' && j != i
              changed_board[j] = x
              changed_board[i] = nil
              p "inr_white_change"
              puts "CB: #{changed_board}"
              @feedback_board.state[j] = 1
              p @feedback_board.state
              p "inr_white_break"
              break
            end
            p "index #{j} skipped"
          end
        else
          loop do
            random_num = rand(1..@color_count).to_s
            if !(changed_board.include?(random_num))
              changed_board[i] = random_num
              p "otr_random_num"
              break
            end
          end
          @feedback_board.state[i] = 1
        end
      end
      changed_board.each_with_index do |z, k|
        if z == nil
          loop do
            random_num = rand(1..@color_count).to_s
            if !(changed_board.include?(random_num)) && !(@guess_board.state.include?(random_num))
              changed_board[k] = random_num
              p "otr_random_num"
              break
            end
          end
        end
      end
      puts "CB: #{changed_board}"
      @guess_board.state = changed_board
    end
    # rubocop:enable Metrics/AbcSize
    # rubocop:enable Metrics/MethodLength

  end
end
