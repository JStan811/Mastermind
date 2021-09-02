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
