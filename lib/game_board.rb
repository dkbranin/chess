# frozen_string_literal: true

require_relative 'piece'

# This class stores the placement of all pieces.
class GameBoard
  attr_reader :white_pieces, :black_pieces

  def initialize
    @white_pieces = create_white_pieces
    @black_pieces = create_black_pieces
  end

  def all_squares
    ordinal_array = Array.new(8) { |number| number }
    holding_array = []
    ordinal_array.repeated_permutation(2) { |permutation| holding_array << permutation }
    holding_array
  end

  def merged_locations
    white_pieces + black_pieces
  end

  def coordinate_lookup(coords, array = merged_locations)
    array.find { |piece| piece.coordinates == coords }
  end

  def all_occupied_squares(array = merged_locations)
    array.map { |piece| piece&.coordinates }
  end

  def change_piece(old_coordinates, new_coordinates)
    piece = coordinate_lookup(old_coordinates)
    return if piece.validate_move(new_coordinates) == false

    piece.coordinates = new_coordinates
    print_board
  end

  def occupied_by_own?(move, own_color)
    coordinate_lookup(move)&.color == own_color
  end

  def print_board
    PrintBoard.new(all_squares, merged_locations).print_board
  end

  private

  def create_white_pieces
    [Pawn.new([6, 0], :white), Pawn.new([6, 1], :white), Pawn.new([6, 2], :white), Pawn.new([6, 3], :white), Pawn.new([6, 4], :white),
     Pawn.new([6, 5], :white), Pawn.new([6, 6], :white), Pawn.new([6, 7], :white), Rook.new([7, 0], :white), Rook.new([7, 7], :white),
     Knight.new([7, 1], :white), Knight.new([7, 6], :white), Bishop.new([7, 2], :white), Bishop.new([7, 5], :white), Queen.new([7, 3], :white),
     King.new([7, 4], :white)]
  end

  def create_black_pieces
    [Pawn.new([1, 0], :black), Pawn.new([1, 1], :black), Pawn.new([1, 2], :black), Pawn.new([1, 3], :black), Pawn.new([1, 4], :black),
     Pawn.new([1, 5], :black), Pawn.new([1, 6], :black), Pawn.new([1, 7], :black), Rook.new([0, 0], :black), Rook.new([0, 7], :black),
     Knight.new([0, 1], :black), Knight.new([0, 6], :black), Bishop.new([0, 2], :black), Bishop.new([0, 5], :black), Queen.new([0, 3], :black),
     King.new([0, 4], :black)]
  end
end
