# frozen_string_literal: true

require_relative '../lib/side'

describe Side do
  describe '#initial_positions' do
    context 'when the game begins for White' do
      subject(:white_side) { described_class.new( 'white' ) }
      it 'lists the coordinates of pieces at their starting positions' do
        white_positions = white_side.initial_positions
        expect(white_positions).to eq(
          { pawn_a: [6, 0],
            pawn_b: [6, 1],
            pawn_c: [6, 2],
            pawn_d: [6, 3],
            pawn_e: [6, 4],
            pawn_f: [6, 5],
            pawn_g: [6, 6],
            pawn_h: [6, 7],
            rook_a: [7, 0],
            rook_h: [7, 7],
            knight_b: [7, 1],
            knight_g: [7, 6],
            bishop_c: [7, 2],
            bishop_f: [7, 5],
            queen: [7, 3],
            king: [7, 4] }
        )
      end
    end

    context 'when the game begins for Black' do
      subject(:black_side) { described_class.new( 'black' ) }
      it 'lists the coordinates of pieces at their initial positions' do
        black_positions = black_side.initial_positions
        expect(black_positions).to eq(
          { pawn_a: [1, 0],
            pawn_b: [1, 1],
            pawn_c: [1, 2],
            pawn_d: [1, 3],
            pawn_e: [1, 4],
            pawn_f: [1, 5],
            pawn_g: [1, 6],
            pawn_h: [1, 7],
            rook_a: [0, 0],
            rook_h: [0, 7],
            knight_b: [0, 1],
            knight_g: [0, 6],
            bishop_c: [0, 2],
            bishop_f: [0, 5],
            queen: [0, 3],
            king: [0, 4] }
        )
      end
    end
  end
end
