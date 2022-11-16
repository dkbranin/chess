# frozen_string_literal: true

# This class contains methods to validate that a move can be played.
class Move
  attr_reader :board, :moving_piece_color, :piece, :new_coordinates

  def initialize(piece, new_coordinates, board = GameBoard.new, moving_piece_color = :white)
    @board = board
    @moving_piece_color = moving_piece_color
    @piece = piece
    @new_coordinates = new_coordinates
    @opponent_color = opponent_color
  end

  def move_checks
    return false if piece.validate_move(new_coordinates) == false
    return false if check_same_color_blocks == false
    return false if taking_own_piece? == true
    return false if check_opponent_blocks == false

    make_move
  end

  def opponent_color
    moving_piece_color == :white ? :black : :white
  end

  def capture_attempt?
    board.coordinate_lookup(new_coordinates).color == opponent_color
  end

  def capture
    captured_piece = board.coordinate_lookup(new_coordinates)
    captured_piece.coordinates = nil
  end

  def make_move(game_board = board)
    game_board.change_piece(piece.coordinates, new_coordinates)
  end

  def check_same_color_blocks
    return true unless piece.pathing

    traversed_path = Path.new.path_choice(piece.coordinates, new_coordinates)
    return false if traversed_path.any? { |square| board.coordinate_lookup(square)&.color = moving_piece_color } # prompt for input

    true
  end

  def taking_own_piece?
    board.occupied_by_own?(new_coordinates, opponent_color)
  end

  def check_opponent_blocks
    return true unless piece.pathing

    traversed_path = Path.new.path_choice(piece.coordinates, new_coordinates)
    traversed_path.pop
    return false if traversed_path.any? { |square| board.coordinate_lookup(square)&.color = opponent } # prompt for input

    true
  end
end

# Capturing
# Knight move validation
# Stringing logic together so game can be demoed
# Check
# Checkmate
# Castling
