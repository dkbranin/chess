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

  def horizontal_check_squares
    king = board.all_occupied_squares.find { |piece| piece.name == 'King' && piece.color == :moving_piece_color }
    Check.new(king).linear_check_possibilities
  end

  def diagonal_check_squares
    king = board.all_occupied_squares.find { |piece| piece.name == 'King' && piece.color == :moving_piece_color }
    Check.new(king).diagonal_check_possibilities
  end

  def linear_check?(straight_arrays, piece_array)
    checked_piece = false
    straight_arrays.each do |array|
      array.each do |coord|
        break if board.coordinate_lookup(coord)&.color == :moving_piece_color

        checked_piece = true if piece_array.include?(board.coordinate_lookup(coord).name)
        break if checked_piece
      end
      break if checked_piece
    end
    checked_piece
  end

  def linear_attacks
    linear_check?(horizontal_check_squares, %w[Queen Rook])
  end

  def diagonal_attacks
    linear_check?(diagonal_check_squares, %w[Queen Bishop])
  end

  def knight_attacking?
    board.all_occupied_squares.find { |piece| piece.name == 'King' && piece.color == :moving_piece_color }
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
    return true if traversed_path.any? { |coords| board.all_occupied_squares.include?(coords) } # prompt for input

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
