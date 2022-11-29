# frozen_string_literal: true

require_relative '../lib/move_builder'
require_relative '../lib/coordinate_mapper'

describe MoveBuilder do
  describe '#blocked?' do
    let(:bishop) { double('Bishop', coordinates: [4, 4], color: :white) }
    let(:board) { double('Board') }
    subject(:move) { described_class.new(bishop, :white) }
    context 'when a move is blocked' do
      let(:pawn) { double('Pawn', coordinates: [6, 6]) }
      before do
        allow(board).to receive(:all_occupied_coordinates).and_return([[5, 5], [6, 6]])
        allow(pawn).to receive(:include?)
        allow(bishop).to receive(:name).and_return('Bishop')
      end
      it 'returns true' do
        validation = move.blocked?([7, 7])
        expect(validation).to eq(true)
      end
    end

    context 'when a move is not blocked' do
      let(:pawn) { double('Pawn', coordinates: [6, 5]) }
      before do
        allow(board).to receive(:all_occupied_coordinates).and_return([6, 5])
        allow(pawn).to receive(:include?)
        allow(bishop).to receive(:name).and_return('Bishop')
      end
      it 'returns false' do
        validation = move.blocked?([6, 5])
        expect(validation).to eq(false)
      end
    end
  end

  describe '#maximum_piece_range' do
    let(:rook) { Rook.new([4, 4], :white) }
    subject(:move) { described_class.new(rook, :white) }
    context 'when a move is attempted' do
      it 'provides a complete list of possible coordinates' do
        moves = move.maximum_piece_range
        expect(moves).to eq([[0, 4], [1, 4], [2, 4], [3, 4], [4, 0], [4, 1], [4, 2], [4, 3], [4, 4], [4, 5], [4, 6], [4, 7], [5, 4], [6, 4], [7, 4]])
      end
    end
  end

  describe '#exclude_own_color' do
    let(:rook) { Rook.new([4, 4], :white) }
    subject(:move) { described_class.new(rook, :white) }
    context 'when a move is attempted' do
      it 'exempts pieces of the moving color' do
        moves = move.exclude_own_color
        expect(moves).to eq([[0, 4], [1, 4], [2, 4], [3, 4], [4, 0], [4, 1], [4, 2], [4, 3], [4, 5], [4, 6], [4, 7], [5, 4]])
      end
    end
  end
end
