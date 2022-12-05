# frozen_string_literal: true

require_relative 'coordinate_mapper'
require_relative 'messaging'
require_relative 'move_logger'

# This class stores the placement of all pieces.
class GameBoard
  include CoordinateMapper
  include Messaging
  attr_reader :state, :log

  def initialize
    @state = initial_state
    @log = MoveLogger.new
  end

  def initial_state
    BoardBuilder.new.initial_state
  end

  def coordinate_lookup(coords, array = state)
    array.find { |piece| piece.coordinates == coords }
  end

  def all_occupied_coordinates(array = state)
    actual_pieces = array.reject { |piece| piece.name.nil? }
    actual_pieces.map(&:coordinates)
  end

  def get_specific_piece(name, color, array = state)
    array.filter { |piece| piece.name == name && piece.color == color }
  end

  def remove_piece(piece, array = state)
    array.delete_if { |potential_piece| piece == potential_piece }
  end

  def change_piece(old_coordinates, new_coordinates)
    piece = coordinate_lookup(old_coordinates)
    piece.coordinates = new_coordinates
    state.push(EmptySquare.new(old_coordinates))
    state.delete_if { |square| square.coordinates == new_coordinates && square.instance_of?(EmptySquare) }
    log_move(old_coordinates, new_coordinates)
  end

  def log_move(old_coordinates, new_coordinates)
    log.log_move([coordinate_to_symbol(old_coordinates), coordinate_to_symbol(new_coordinates)])
    log.print_log
  end

  def piece_moved?(coordinate)
    log.first_moves.include?(coordinate_to_symbol(coordinate))
  end

  def pieces_of_color(color, array = state)
    array.filter do |piece|
      piece.color == color
    end
  end

  def occupied_by_own?(move, own_color)
    coordinate_lookup(move)&.color == own_color
  end

  def print_board
    BoardDisplay.new(state).print_board
  end
end
