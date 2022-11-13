# frozen_string_literal: true

class Side
  attr_reader :color

  def initialize(color)
    @color = color
  end

  def initial_positions
    return pieces(6, 7) if color == 'white'
    return pieces(1, 0) if color == 'black'
  end

  def pieces(first_row, second_row)
    { pawn_a: [first_row, 0], pawn_b: [first_row, 1], pawn_c: [first_row, 2], pawn_d: [first_row, 3],
      pawn_e: [first_row, 4], pawn_f: [first_row, 5], pawn_g: [first_row, 6], pawn_h: [first_row, 7],
      rook_a: [second_row, 0], rook_h: [second_row, 7], knight_b: [second_row, 1], knight_g: [second_row, 6],
      bishop_c: [second_row, 2], bishop_f: [second_row, 5], queen: [second_row, 3], king: [second_row, 4] }
  end
end
