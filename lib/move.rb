# frozen_string_literal: true

class Move
  attr_reader :board, :moving_piece_color, :piece, :new_coordinates

  def initialize(piece, new_coordinates, board = GameBoard.new, moving_piece_color = :white)
    @board = board
    @moving_piece_color = moving_piece_color
    @piece = piece
    @new_coordinates = new_coordinates
    @opponent_color = opponent_color
  end

  def opponent_color
    moving_piece_color == :white ? :black : :white
  end

  def capture_attempt?
    board.coordinate_lookup[new_coordinates].color = opponent_color
  end

  def make_move(old_coords, new_coords, game_board = board)
    game_board.change_piece(old_coords, new_coords)
  end

  def check_same_color_blocks
    return true unless piece.pathing

    traversed_path = Path.new(piece.coordinates, new_coordinates).path_choice
    return false if traversed_path.any? { |square| board.coordinate_lookup[square]&.color = moving_piece_color } # prompt for input

    true
  end

  def check_opponent_blocks
    return true unless piece.pathing

    traversed_path = Path.new(piece.coordinates, new_coordinates).path_choice
    traversed_path.pop
    return false if traversed_path.any? { |square| board.coordinate_lookup[square]&.color = opponent } # prompt for input

    true
  end
end

# Validate that a move is within a piece's range of motion
# Validate that the piece is not blocked
# Validate that the square is not occupied by 
