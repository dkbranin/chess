# frozen_string_literal: true

class MoveBuilder
  attr_reader :piece, :own_color

  def initialize(piece, color, board)
    @piece = piece
    @own_color = color
    @board = board
  end

  def maximum_piece_range(active_piece = piece)
    all_coordinates.filter { |coordinate| active_piece.validate_move(board.coordinate_lookup(coordinate)) }
  end

  def exclude_own_color(color = own_color, active_piece = piece)
    same_color_coords = board.pieces_of_color(color).map(&:coordinates)
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
end
