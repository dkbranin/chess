# frozen_string_literal: true

require_relative '../lib/move'

describe Move do
  describe '#make_move' do
    let(:fake_piece) { double('Piece') }
    let(:board) { double('GameBoard') }
    subject(:move) { described_class.new(fake_piece, [5, 0]) }
    context 'when a piece is moved' do
      it 'sends the coordinates to the game board' do
        expect(board).to receive(:change_piece)
        move.make_move([5,0], [6, 0], board)
      end
    end
  end

  describe '#validate_move' do
  end
end
