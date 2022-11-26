# frozen_string_literal: true

require_relative 'coordinate_mapper'

class BoardBuilder
  include CoordinateMapper

  def merged_locations
    create_white_pieces + create_black_pieces
  end

  def empty_spaces(array = merged_locations)
    empty_coordinates = all_coordinates - array.map(&:coordinates)
    empty_coordinates.map { |coordinate| EmptySquare.new(coordinate) }
  end

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

  def initial_state
    merged_locations + empty_spaces
  end
end
