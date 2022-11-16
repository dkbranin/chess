# frozen_string_literal: true

require_relative '../lib/move'

describe Move do
  describe '#make_move' do
    let(:fake_piece) { double('Piece', coordinates: [6, 0]) }
    let(:board) { double('GameBoard') }
    subject(:move) { described_class.new(fake_piece, [5, 0], board) }
    context 'when a piece is moved' do
      it 'sends the coordinates to the game board' do
        expect(board).to receive(:change_piece)
        move.make_move
      end
    end
  end

  describe '#validate_move' do
  end
end
