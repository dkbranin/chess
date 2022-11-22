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
    return false if invalid_pawn_capture?
    return false if piece.validate_move(new_coordinates) == false
    return false if blocked?
    return false if taking_own_piece? == true

    capture if capture_attempt?
    make_move
  end

  def piece_range
    CoordinateMapper.new.all_coordinates.filter { |coordinate| piece.validate_move(coordinate) }
  end

  def not_own_color
    piece_range - board.pieces_of_color(:moving_piece_color)
  end

  def horizontal_check_squares
    Check.new(king).linear_check_possibilities
  end

  def king
    board.get_specific_piece('King', :moving_piece_color)[0]
  end

  def diagonal_check_squares
    Check.new(king).diagonal_check_possibilities
  end

  def make_move(game_board = board)
    game_board.change_piece(piece.coordinates, new_coordinates)
  end

  def capture
    captured_piece = board.coordinate_lookup(new_coordinates)
    captured_piece.coordinates = nil
  end

  def invalid_pawn_capture?
    return false unless piece.name == 'Pawn'
    return false unless piece.coordinates[1] == new_coordinates[1]
    return false unless capture_attempt?

    true
  end

  def opponent_color
    moving_piece_color == :white ? :black : :white
  end

  def capture_attempt?
    board.coordinate_lookup(new_coordinates)&.color == opponent_color
  end

  def blocked?
    return false if piece.name == 'Knight'

    traversed_path = Path.new.path_choice(piece.coordinates, new_coordinates)
    return true if traversed_path.any? { |coords| board.all_occupied_coordinates.include?(coords) } # prompt for input

    false
  end

  def taking_own_piece?
    board.occupied_by_own?(new_coordinates, moving_piece_color)
  end
end

# Capturing
# Knight move validation
# Stringing logic together so game can be demoed
# Check
# Checkmate
# Castling
