# frozen_string_literal: true

module Mastermind
  # this contains the logic of a game where computer guesses the code
  class GameComputerGuesses < Game
    def play_game_computer_guesses
      puts 'Welcome to Mastermind.'
      puts 'Player, you are the Codemaker. Submit your code and the computer will try to guess it.'
      # user makes code, program saves it into code_board.state
      @code_board.state = [5, 6, 2, 3] # filler
      # computer guesses, then game checks win
      puts 'Initial guess:'
      computer_generate_guess
      puts "Guess Board: #{@guess_board.state}"
      puts ''
      if check_win?
        puts 'Computer has guessed correctly. You lose.'
        return
      end
      # computer changes submission up to 12 times (round) based on feedback
      # game declares player winner or player loser
      loop_through_turns_computer_guessing
      puts 'Game over.'
      # new game?
    end

    private

    # rubocop:disable Metrics/MethodLength
    def collect_maker_code
      # prompt maker for code
      puts 'Codemaker, place a peg (1-6) in position 1. No duplicates or blanks.'
      color1 = gets.chomp
      puts 'Codemaker, place a peg (1-6) in position 2. No duplicates or blanks.'
      color2 = gets.chomp
      puts 'Codemaker, place a peg (1-6) in position 3. No duplicates or blanks.'
      color3 = gets.chomp
      puts 'Codemaker, place a peg (1-6) in position 4. No duplicates or blanks.'
      color4 = gets.chomp
      @codemaker.make_code(@code_board, color1, color2, color3, color4)

      # print state for debugging (may be replaced by display)
      puts "Code Board: #{@code_board.state}"
      puts ''
    end
    # rubocop:enable Metrics/MethodLength

    def computer_guessing_code
      # first random generate 4 numbers (could also just do 1234 every first round, that's what I do)
      computer_generate_guess
      # then keep changing guess based on feedback up to 12 times or until the code is right
      # change logic: keep blacks the same, move whites one position to the right, increase nils by 1 (skipping over whites and blacks)
    end

    def computer_generate_guess
      @guess_board.state.map! do
        # check if random_color exists in array to avoid duplicates
        random_color = rand(1..6)
        random_color = rand(1..6) while @guess_board.state.include?(random_color.to_s)
        random_color.to_s # convert to strings b/c currently guess board is strings. Needed for feedback engine to work
      end
    end

    def computer_change_guess_just_black
      @guess_board.state.each_with_index do |num, i|
        if @feedback_board.state[i] == 'Black'
          next
        else
          @guess_board.state[i] = rand(1..6)
        end
      end
    end

    def computer_change_guess
      # look at feedback engine. if there is a black, keep that position the same in the guess board. if white, move the color in that position one to the right skipping over black. if nil, randomize (update this in the future to randomize, skipping blacks and whites)
      @guess_board.state.each_with_index do |num, i|
        if @feedback_board.state[i] == 'Black'
          next
        elsif @feedback_board.state[i] == 'White'
          @guess_board.state[i + 1] = num
        else
          @guess_board.state[i] = rand(1..6)
        end
      end
    end

    def computer_guess_turn
      feedback_engine
      # computer change guess
      computer_change_guess_just_black
      puts "Guess Board: #{@guess_board.state}"
    end

    # rubocop:disable Metrics/MethodLength
    def loop_through_turns_computer_guessing
      (1..@round_count).each do |i|
        @feedback_board.reset # reset feedback_board
        puts ''
        puts "Round #{i}:"
        computer_guess_turn
        if check_win?
          puts "Code Board: #{@code_board.state}"
          puts 'Computer has guessed correctly. You lose.'
          break
        end
        if i == 12
          puts "Code Board: #{@code_board.state}"
          puts 'Computer was not able to guess your code. You win.'
          break
        end
      end
    end
    # rubocop:enable Metrics/MethodLength
  end
end
