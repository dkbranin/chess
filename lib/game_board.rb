# frozen_string_literal: true

# This class stores the placement of all pieces.
class GameBoard
  attr_reader :white_side, :black_side

  def initialize(white = Side.new('white'), black = Side.new('black'))
    @white_side = white
    @black_side = black
  end

  def all_squares
    ordinal_array = Array.new(8) { |number| number }
    holding_array = []
    ordinal_array.repeated_permutation(2) { |permutation| holding_array << permutation }
    holding_array
  end
end
