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

  def all_positions
    all_squares.map do |coordinate|
      piece = "White #{white_side.coord_lookup(coordinate).name}" unless white_side.coord_lookup(coordinate).nil?
      piece = "Black #{black_side.coord_lookup(coordinate).name}" unless black_side.coord_lookup(coordinate).nil?

      piece = 'Unoccupied' if piece.nil?
      piece
    end
  end

  def print_board
    PrintBoard.new
  end

  def initial_piece_positions(first_row, second_row)
    { pawn_a: [first_row, 0], pawn_b: [first_row, 1], pawn_c: [first_row, 2], pawn_d: [first_row, 3],
      pawn_e: [first_row, 4], pawn_f: [first_row, 5], pawn_g: [first_row, 6], pawn_h: [first_row, 7],
      rook_a: [second_row, 0], rook_h: [second_row, 7], knight_b: [second_row, 1], knight_g: [second_row, 6],
      bishop_c: [second_row, 2], bishop_f: [second_row, 5], queen: [second_row, 3], king: [second_row, 4] }
  end
end
