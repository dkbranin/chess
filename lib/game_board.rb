# frozen_string_literal: true

# This class stores the placement of all pieces.
class GameBoard
  def all_squares
    ordinal_array = Array.new(8) { |number| number }
    holding_array = []
    ordinal_array.repeated_permutation(2) { |permutation| holding_array << permutation }
    holding_array
  end
end
