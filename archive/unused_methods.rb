# rubocop:disable Metrics/MethodLength
# from game_computer_guesses.rb
def collect_maker_code_chars
  # prompt maker for code
  puts "Codemaker, place a peg (1-#{@color_count}) in position 1. No duplicates or blanks."
  color1 = gets.chomp
  puts "Codemaker, place a peg (1-#{@color_count}) in position 2. No duplicates or blanks."
  color2 = gets.chomp
  puts "Codemaker, place a peg (1-#{@color_count}) in position 3. No duplicates or blanks."
  color3 = gets.chomp
  puts "Codemaker, place a peg (1-#{@color_count}) in position 4. No duplicates or blanks."
  color4 = gets.chomp
  @codemaker.make_code(@code_board, color1, color2, color3, color4)

  # print state for debugging (may be replaced by display)
  puts "Code Board: #{@code_board.state}"
  puts ''
end
# rubocop:enable Metrics/MethodLength

# rubocop:disable Metrics/MethodLength
# from game_player_guesses.rb
def collect_breaker_guess_chars
  # prompt breaker for guess
  puts "Codebreaker, place a peg (1-#{@color_count}) in position 1. No duplicates or blanks."
  color1 = gets.chomp
  puts "Codebreaker, place a peg (1-#{@color_count}) in position 2. No duplicates or blanks."
  color2 = gets.chomp
  puts "Codebreaker, place a peg (1-#{@color_count}) in position 3. No duplicates or blanks."
  color3 = gets.chomp
  puts "Codebreaker, place a peg (1-#{@color_count}) in position 4. No duplicates or blanks."
  color4 = gets.chomp
  @codebreaker.make_guess(@guess_board, color1, color2, color3, color4)

  # print state for debugging (may be replaced by display)
  puts "Guess Board: #{@guess_board.state}"
  puts ''
end
# rubocop:enable Metrics/MethodLength


# this is from game_computer_guesses and includes debugging prints
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
