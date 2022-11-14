# frozen_string_literal: true

# This class stores the placement of all pieces.
class GameBoard
  attr_reader :white, :black

  def initialize(white = Side.new('white'), black = Side.new('black'))
    @white = white
    @black = black
  end

  def all_squares
    ordinal_array = Array.new(8) { |number| number }
    holding_array = []
    ordinal_array.repeated_permutation(2) { |permutation| holding_array << permutation }
    holding_array
  end

  def merged_locations
    coord_map(white.pieces).merge(coord_map(black.pieces))
  end

  def coord_map(piece_hash)
    new_hash = {}
    piece_hash.each_value do |piece|
      new_hash[piece.coordinates] = piece
    end
    new_hash
  end

  def print_board
    PrintBoard.new(all_squares, merged_locations).print_board
  end
end
