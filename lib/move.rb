# frozen_string_literal: true

require 'pry-byebug'
# This class contains methods to validate that a move can be played.
class Move
  include CoordinateMapper
  include Messaging
  attr_reader :board, :color, :piece, :new_coordinates

  def initialize(piece:, new_coordinates:, color: piece.color, board: GameBoard.new)
    @board = board
    @color = color
    @piece = piece
    @new_coordinates = new_coordinates
  end

  def move_validation(coordinates = new_coordinates)
    MoveBuilder.new(piece, color, board).exclude_blocked_moves.include?(coordinates) && !would_end_in_check?
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

  # Check methods

  def king(color)
    board.get_specific_piece('King', color)[0]
  end

  def would_end_in_check?
    temp_state = Marshal.load(Marshal.dump(board))
    temp_piece = piece.dup
    alter_board(temp_state, temp_piece)
    Move.new(piece: temp_piece, new_coordinates: king(color).coordinates, board: temp_state).in_check?
  end

  def in_check?
    squares_under_attack.include?(king(color).coordinates)
  end

  def squares_under_attack
    attacked_squares = []
    board.pieces_of_color(opponent_color).each do |opponent_piece|
      not_color = move_builder.exclude_own_color(opponent_color, opponent_piece)
      attacked_squares.push(move_builder.exclude_blocked_moves(not_color, opponent_piece))
    end
    attacked_squares.flatten(1).uniq
  end

  def move_builder(builder_piece: piece)
    MoveBuilder.new(builder_piece, color, board)
  end

  def opponent_color
    color == :white ? :black : :white
  end
end

# Checkmate
# Castling

