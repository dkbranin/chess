# frozen_string_literal: true

require_relative 'piece'
require_relative 'empty_square'

# This class stores the placement of all pieces.
class GameBoard
  attr_reader :white_pieces, :black_pieces, :open_spaces

  def initialize
    @white_pieces = create_white_pieces
    @black_pieces = create_black_pieces
    @open_spaces = empty_spaces
  end

  def merged_locations
    white_pieces + black_pieces
  end

  def empty_spaces(array = merged_locations)
    empty_coordinates = CoordinateMapper.new.all_coordinates - array.map(&:coordinates)
    empty_coordinates.map { |coordinate| EmptySquare.new(coordinate) }
  end

  def board_state
    merged_locations + open_spaces
  end

  def coordinate_lookup(coords, array = board_state)
    array.find { |piece| piece.coordinates == coords }
  end

  def all_occupied_coordinates(array = board_state)
    array.map { |piece| piece&.coordinates }
  end

  def get_specific_piece(name, color, array = board_state)
    array.filter { |piece| piece == name && piece == color }
  end

  def change_piece(old_coordinates, new_coordinates)
    piece = coordinate_lookup(old_coordinates)
    piece.coordinates = new_coordinates
    print_board
  end

  def pieces_of_color(color, array = board_state)
    array.filter { |piece| piece.color == color }
  end

  def occupied_by_own?(move, own_color)
    coordinate_lookup(move)&.color == own_color
  end

  def print_board
    BoardDisplay.new(board_state).print_board
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