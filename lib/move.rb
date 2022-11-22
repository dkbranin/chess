# frozen_string_literal: true

# This class contains methods to validate that a move can be played.
class Move
  attr_reader :board, :moving_piece_color, :piece, :new_coordinates

  def initialize(piece, new_coordinates, board = GameBoard.new)
    @board = board
    @moving_piece_color = piece.color
    @piece = piece
    @new_coordinates = new_coordinates
    @opponent_color = opponent_color
  end

  def move_checks
    return false unless eliminate_blocked_options.include?(new_coordinates)
    return false if would_end_in_check?

    alter_board
  end

  def alter_board(game_board = board)
    capture(game_board) if capture_attempt?(game_board)
    make_move(game_board)
  end

  def would_end_in_check?
    temp_state = board.dup
    alter_board(temp_state)
    Move.new(piece, new_coordinates, temp_state).in_check?
  end

  def piece_range(active_piece = piece)
    CoordinateMapper.new.all_coordinates.filter { |coordinate| active_piece.validate_move(board.coordinate_lookup(coordinate)) }
  end

  def not_own_color(color = moving_piece_color, active_piece = piece)
    same_color_coords = board.pieces_of_color(color).map(&:coordinates)
    (piece_range(active_piece) - same_color_coords).reject { |coordinates| active_piece.coordinates == coordinates }
  end

  def king
    board.get_specific_piece('King', moving_piece_color)[0]
  end

  def make_move(game_board = board)
    game_board.change_piece(piece.coordinates, new_coordinates)
  end

  def capture(game_board = board)
    captured_piece = game_board.coordinate_lookup(new_coordinates)
    board.remove_piece(captured_piece)
  end

  def opponent_color
    moving_piece_color == :white ? :black : :white
  end

  def capture_attempt?(game_board = board)
    game_board.coordinate_lookup(new_coordinates)&.color == opponent_color
  end

  def blocked?(target = new_coordinates, active_piece = piece)
    return false if active_piece.name == 'Knight'

    traversed_path = Path.new.path_choice(active_piece.coordinates, target)
    return true if traversed_path.any? { |coords| board.all_occupied_coordinates.include?(coords) } # prompt for input

    false
  end

  def eliminate_blocked_options(array = not_own_color, active_piece = piece)
    array.reject { |coordinate| blocked?(coordinate, active_piece) }
  end

  def check_squares
    check_square_array = []
    board.pieces_of_color(opponent_color).each do |opp_piece|
      not_color = not_own_color(opponent_color, opp_piece)
      check_square_array.push(eliminate_blocked_options(not_color, opp_piece))
    end
    p check_square_array.flatten(1).uniq
    check_square_array.flatten(1).uniq
  end

  def in_check?
    check_squares.include?(king.coordinates)
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
