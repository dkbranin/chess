# frozen_string_literal: true

class Move
  attr_reader :board

  def initialize(board = GameBoard.new)
    @board = board
  end

  def make_move(old_coords, new_coords, game_board = board)
    game_board.change_piece(old_coords, new_coords)
  end
end
