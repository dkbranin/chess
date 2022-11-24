# frozen_string_literal: true

# This class contains information about a player and provides various input and output methods.
class Player
  attr_reader :color

  def initialize(color = :white)
    @color = color
  end

  def export_coordinates
    raw = validate_input
    p raw
    CoordinateMapper.new.coordinate_lookup(raw)
  end

  def validate_input
    prospective_move = input_obtainer
    return end_program if prospective_move == 'quit'

    invalid_input unless valid_input?(prospective_move)

    [prospective_move[0, 2].to_sym, prospective_move[2, 4].to_sym]
  end

  def valid_input?(input)
    input.match?(/^[a-h][1-8][a-h][1-8]$/)
  end

  def invalid_input
    puts "Sorry, that's not a valid move. Please type the coordinate of one of your pieces, \
    then the coordinate of the piece you'd like to move to. (For example, d2d4)."
  end

  private

  def end_program
    exit(0)
  end

  def input_obtainer
    puts 'What move would you like to make? Select the coordinates of the piece you \
    would like to move, then the coordiates of the square you would like to move \
    to. (For example, d2d4).'
    gets.chomp
  end
end
