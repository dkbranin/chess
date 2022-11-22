# frozen_string_literal: true

class CoordinateMapper
  def coordinate_lookup(symbols)
    symbols.map { |symbol| symbol_and_coord[symbol] }
  end

  def symbol_and_coord
    coord_mapping_hash = {}
    chess_notation.each_with_index { |symbol, index| coord_mapping_hash[symbol] = all_coordinates[index] }
    coord_mapping_hash
  end

  def all_coordinates
    ordinal_array = Array.new(8) { |number| number }
    holding_array = []
    ordinal_array.repeated_permutation(2) { |permutation| holding_array << permutation }
    holding_array
  end

  private

  def letter_and_number(number)
    letters = %w[a b c d e f g h]
    letters.map { |letter| (letter + number.to_s).to_sym }
  end

  def chess_notation
    array = []
    8.downto(1) do |number|
      array.push(letter_and_number(number))
    end
    array.flatten
  end
end
