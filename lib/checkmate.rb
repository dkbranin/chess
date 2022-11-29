# frozen_string_literal: true

# Determines if the board is in checkmate.
class Checkmate
  attr_reader :color, :board

  def initialize(color, board = GameBoard.new)
    @color = color
    @board = board
  end

  def checkmate?
    board.pieces_of_color(color).all? do |own_piece|
      new_builder = move_builder(own_piece)
      color_exclude = new_builder.exclude_own_color
      possible_ends = new_builder.exclude_blocked_moves(color_exclude, own_piece)
      p possible_ends
      possible_ends.none? do |coordinate|
        clone_board(own_piece, coordinate).move_validation
      end
    end
  end

  def clone_board(possible_piece, coordinate)
    temp_state = Marshal.load(Marshal.dump(board))
    temp_piece = possible_piece.dup
    p temp_piece
    Move.new(piece: temp_piece, new_coordinates: coordinate, board: temp_state)
  end

  def move_builder(build_piece)
    MoveBuilder.new(build_piece, color, board)
  end
end
