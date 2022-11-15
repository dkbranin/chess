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
    white_pieces.merge(black_pieces)
  end

  def create_white_pieces
    { w_pawn_a: Pawn.new([6, 0], :white), w_pawn_b: Pawn.new([6, 1], :white), w_pawn_c: Pawn.new([6, 2], :white), w_pawn_d: Pawn.new([6, 3], :white),
      w_pawn_e: Pawn.new([6, 4], :white), w_pawn_f: Pawn.new([6, 5], :white), w_pawn_g: Pawn.new([6, 6], :white), w_pawn_h: Pawn.new([6, 7], :white),
      w_rook_a: Rook.new([7, 0], :white), w_rook_h: Rook.new([7, 7], :white), w_knight_b: Knight.new([7, 1], :white), w_knight_g: Knight.new([7, 6], :white),
      w_bishop_c: Bishop.new([7, 2], :white), w_bishop_f: Bishop.new([7, 5], :white), w_queen: Queen.new([7, 3], :white), w_king: King.new([7, 4], :white) }
  end

  def create_black_pieces
    { b_pawn_a: Pawn.new([1, 0], :black), b_pawn_b: Pawn.new([1, 1], :black), b_pawn_c: Pawn.new([1, 2], :black), b_pawn_d: Pawn.new([1, 3], :black),
      b_pawn_e: Pawn.new([1, 4], :black), b_pawn_f: Pawn.new([1, 5], :black), b_pawn_g: Pawn.new([1, 6], :black), b_pawn_h: Pawn.new([1, 7], :black),
      b_rook_a: Rook.new([0, 0], :black), b_rook_h: Rook.new([0, 7], :black), b_knight_b: Knight.new([0, 1], :black), b_knight_g: Knight.new([0, 6], :black),
      b_bishop_c: Bishop.new([0, 2], :black), b_bishop_f: Bishop.new([0, 5], :black), b_queen: Queen.new([0, 3], :black), b_king: King.new([0, 4], :black) }
  end

  def coordinate_lookup(hash = merged_locations)
    new_hash = {}
    hash.each_value do |piece|
      new_hash[piece.coordinates] = piece
    end
    new_hash
  end

  def occupied_coordinates(hash = merged_locations)
    coord_array = []
    hash.each_value do |piece|
      piece.coordiates << coord_array
    end
    coord_array
  end

  def change_piece(piece_symbol, coordinates)
    piece = merged_locations[piece_symbol]
    piece.coordinates = coordinates
    print_board
  end

  def occupied_by_own?(array)
  end

  def print_board
    PrintBoard.new(all_squares, merged_locations).print_board
  end
end
