# frozen_string_literal: true

class Player
  attr_reader :color

  def initialize(color = :white)
    @color = color
  end

  def input_obtainer
    puts 'What move would you like to make? Select the coordinates of the piece you \
    would like to move, then the coordiates of the square you would like to move \
    to. (For example, d2d4).'
    gets.chomp
  end

  def validate_input
    prospective_move = input_obtainer
    invalid_input unless valid_input?(prospective_move)

    prospective_move
  end

  def invalid_input
    puts "Sorry, that's not a valid move. Please type the coordinate of one of your pieces, \
    then the coordinate of the piece you'd like to move to. (For example, d2d4)."
    input_obtainer
  end

  def valid_input?(input)
    input.match?(/^[a-h][1-8][a-h][1-8]$/)
  end

  def first_coordinate(input)
    input_to_coords(input[0, 2])
  end

  def second_coordinate(input)
    input_to_coords(input[2, 2])
  end

  def input_to_coords(user_coord)
    split_coord = user_coord.chars
    [8 - split_coord[1].to_i, letter_hash[split_coord[0]]]
  end

  def letter_hash
    { 'a' => 0,
      'b' => 1,
      'c' => 2,
      'd' => 3,
      'e' => 4,
      'f' => 5,
      'g' => 6,
      'h' => 7 }
  end
end
