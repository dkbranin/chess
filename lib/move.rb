# frozen_string_literal: true

require 'pry-byebug'
# This class contains methods to validate that a move can be played.
class Move
  include CoordinateMapper
  include Messaging
  attr_reader :board, :color, :piece, :new_coordinates

  def initialize(piece, new_coordinates, board = GameBoard.new)
    @board = board
    @color = piece.color
    @piece = piece
    @new_coordinates = new_coordinates
  end

  def move_validation(coordinates = new_coordinates)
    exclude_blocked_moves.include?(coordinates) && !would_end_in_check?
  end

  # Methods to change piece position

  def alter_board(game_board = board, game_piece = piece)
    capture(game_board) if capture_attempt?(game_board)
    make_move(game_board, game_piece)
  end

  def capture(game_board = board)
    captured_piece = game_board.coordinate_lookup(new_coordinates)
    game_board.remove_piece(captured_piece)
  end

  def capture_attempt?(game_board = board)
    game_board.coordinate_lookup(new_coordinates)&.color == opponent_color
  end

  def make_move(game_board = board, game_piece = piece)
    game_board.change_piece(game_piece.coordinates, new_coordinates)
  end

  # Potential move builder methods

  def maximum_piece_range(active_piece = piece)
    all_coordinates.filter { |coordinate| active_piece.validate_move(board.coordinate_lookup(coordinate)) }
  end

  def exclude_own_color(own_color = color, active_piece = piece)
    same_color_coords = board.pieces_of_color(own_color).map(&:coordinates)
    (maximum_piece_range(active_piece) - same_color_coords).reject { |coordinates| active_piece.coordinates == coordinates }
  end

  def blocked?(target, active_piece = piece)
    return false if active_piece.name == 'Knight'

    traversed_path = Path.new.path_choice(active_piece.coordinates, target)
    traversed_path.any? { |coords| board.all_occupied_coordinates.include?(coords) }
  end

  def exclude_blocked_moves(array = exclude_own_color, active_piece = piece)
    array.reject { |coordinate| blocked?(coordinate, active_piece) }
  end

  # Check methods

  def king(color)
    board.get_specific_piece('King', color)[0]
  end

  def would_end_in_check?
    temp_state = Marshal.load(Marshal.dump(board))
    temp_piece = piece.dup
    alter_board(temp_state, temp_piece)
    Move.new(temp_piece, king(color).coordinates, temp_state).in_check?
  end

  def in_check?
    squares_under_attack.include?(king(color).coordinates)
  end

  def squares_under_attack
    attacked_squares = []
    board.pieces_of_color(opponent_color).each do |opponent_piece|
      not_color = exclude_own_color(opponent_color, opponent_piece)
      attacked_squares.push(exclude_blocked_moves(not_color, opponent_piece))
    end
    p attacked_squares.flatten(1).uniq
    attacked_squares.flatten(1).uniq
  end

  def checkmate?
    board.pieces_of_color(color).all? do |own_piece|
      possible_ends = exclude_blocked_moves(exclude_own_color, own_piece)
      possible_ends.none? do |coordinate|
        clone_board(own_piece, coordinate).move_validation
      end
    end
  end

  def clone_board(possible_piece, coordinate)
    temp_state = Marshal.load(Marshal.dump(board))
    temp_piece = possible_piece.dup
    Move.new(temp_piece, coordinate, temp_state)
  end

  def opponent_color
    color == :white ? :black : :white
  end
end

# Checkmate
# Castling

