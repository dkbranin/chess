# frozen_string_literal: true
require_relative 'piece'

class Side
  attr_reader :color, :pieces

  def initialize(color)
    @color = color
    @pieces = pieces_by_color
  end

  def initial_positions
    piece_coordinates(pieces_by_color)
  end

  def pieces_by_color
    return create_pieces(6, 7) if color == 'white'
    return create_pieces(1, 0) if color == 'black'
  end

  def create_pieces(first_row, second_row)
    { pawn_a: Pawn.new([first_row, 0], color), pawn_b: Pawn.new([first_row, 1], color), pawn_c: Pawn.new([first_row, 2], color), pawn_d: Pawn.new([first_row, 3], color),
      pawn_e: Pawn.new([first_row, 4], color), pawn_f: Pawn.new([first_row, 5], color), pawn_g: Pawn.new([first_row, 6], color), pawn_h: Pawn.new([first_row, 7], color),
      rook_a: Rook.new([second_row, 0], color), rook_h: Rook.new([second_row, 7], color), knight_b: Knight.new([second_row, 1], color), knight_g: Knight.new([second_row, 6], color),
      bishop_c: Bishop.new([second_row, 2], color), bishop_f: Bishop.new([second_row, 5], color), queen: Queen.new([second_row, 3], color), king: King.new([second_row, 4], color) }
  end

  def piece_coordinates(piece_hash)
    new_hash = {}
    piece_hash.each_pair do |name, piece|
      new_hash[name] = piece.coordinates
    end
    new_hash
  end

  def coord_lookup(coordinates, piece_hash = pieces)
    new_hash = {}
    piece_hash.each_value do |piece|
      new_hash[piece.coordinates] = piece
    end
    new_hash[coordinates]
  end
end
