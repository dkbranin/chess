# frozen_string_literal: true

class Check
  def initialize(color, board, piece = nil)
    @color = color
    @piece = piece
    @board = board
  end

  def king(color)
    board.get_specific_piece('King', color)[0]
  end

  def would_end_in_check?
    temp_state = Marshal.load(Marshal.dump(board))
    temp_piece = piece.dup
    alter_board(temp_state, temp_piece)
    Move.new(temp_piece, king(moving_piece_color).coordinates, temp_state).in_check?
  end

  def in_check?
    squares_under_attack.include?(king(moving_piece_color).coordinates)
  end

  def squares_under_attack
    attacked_squares = []
    board.pieces_of_color(opponent_color).each do |opponent_piece|
      not_color = exclude_own_color(opponent_color, opponent_piece)
      attacked_squares.push(exclude_blocked_moves(not_color, opponent_piece))
    end
    attacked_squares.flatten(1).uniq
  end

  def checkmate?
    board.pieces_of_color(opponent_color).all? do |opponent_piece|
      possible_ends = exclude_blocked_moves(exclude_own_color, opponent_piece)
      possible_ends.none? { |coordinate| clone_board(opponent_piece, coordinate).move_validation }
    end
  end

  def clone_board(possible_piece, coordinate)
    temp_state = Marshal.load(Marshal.dump(board))
    temp_piece = possible_piece.dup
    Move.new(temp_piece, coordinate, temp_state)
  end
end