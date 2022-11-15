# frozen_string_literal: true

require_relative '../lib/move'

describe Move do
  describe '#make_move' do
    subject(:move) { described_class.new }
    let(:board) { double('GameBoard') }
    context 'when a piece is moved' do
      it 'sends the coordinates to the game board' do
        expect(board).to receive(:make_move)
        move.make_move([2, 4])
      end
    end
  end

  describe '#validate_move' do
  end
end
