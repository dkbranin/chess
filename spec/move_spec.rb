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

  describe '#blocked?' do
    let(:bishop) { double('Bishop', coordinates: [4, 4], pathing: true) }
    let(:board) { double('Board') }
    subject(:move) { described_class.new(bishop, [7, 7], board, :white) }
    context 'when a move is blocked' do
      let(:pawn) { double('Pawn', coordinates: [6, 6]) }
      before do
        allow(board).to receive(:all_occupied_squares).and_return([[5, 5], [6, 6]])
        allow(pawn).to receive(:include?)
      end
      it 'returns true' do
        validation = move.blocked?
        expect(validation).to eq(true)
      end
    end

    context 'when a move is not blocked' do
      let(:pawn) { double('Pawn', coordinates: [6, 5]) }
      before do
        allow(board).to receive(:all_occupied_squares).and_return([6, 5])
        allow(pawn).to receive(:include?)
      end
      it 'returns false' do
        validation = move.blocked?
        expect(validation).to eq(false)
      end
    end
  end

  describe '#capture' do
    let(:knight) { double('Knight', coordinates: [3, 3]) }
    let(:rook) { double('Rook', coordinates: [5, 3]) }
    let(:board) { double('Board') }
    subject(:move) { described_class.new(rook, [3, 3], board, :white) }
    context 'when a capture is attempted' do
      before do
        allow(board).to receive(:coordinate_lookup).and_return(knight)
      end
      it 'changes the coordinates on the captured piece' do
        expect(knight).to receive(:coordinates=)
        move.capture
      end
    end
  end

  describe '#move_checks' do
    context 'when a capture is attempted with a knight' do
      let(:knight) { Knight.new([5, 2], :white) }
      let(:board) { double('Board') }
      let(:pawn) { double('Pawn', coordinates: [3, 3], color: :black) }
      subject(:move) { described_class.new(knight, [3, 3], board, :white) }
      before do
        allow(board).to receive(:occupied_by_own?).and_return(false)
        allow(board).to receive(:coordinate_lookup).and_return(pawn)
        allow(pawn).to receive(:coordinates=)
        allow(board).to receive(:change_piece)
      end
      it 'allows the valid capture' do
        validation = move.move_checks
        expect(validation).not_to eq(false)
      end
    end
  end
end
