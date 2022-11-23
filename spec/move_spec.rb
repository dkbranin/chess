# frozen_string_literal: true

require_relative '../lib/move'
require_relative '../lib/coordinate_mapper'

describe Move do
  describe '#make_move' do
    let(:fake_piece) { double('Piece', coordinates: [6, 0], color: :white) }
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
    let(:bishop) { double('Bishop', coordinates: [4, 4], pathing: true, color: :white) }
    let(:board) { double('Board') }
    subject(:move) { described_class.new(bishop, [7, 7], board) }
    context 'when a move is blocked' do
      let(:pawn) { double('Pawn', coordinates: [6, 6]) }
      before do
        allow(board).to receive(:all_occupied_coordinates).and_return([[5, 5], [6, 6]])
        allow(pawn).to receive(:include?)
        allow(bishop).to receive(:name).and_return('Bishop')
      end
      it 'returns true' do
        validation = move.blocked?
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
        validation = move.blocked?
        expect(validation).to eq(false)
      end
    end
  end

  describe '#capture' do
    let(:knight) { double('Knight', coordinates: [3, 3]) }
    let(:rook) { double('Rook', coordinates: [5, 3], color: :white) }
    let(:board) { double('Board') }
    subject(:move) { described_class.new(rook, [3, 3], board) }
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

  describe '#maximum_piece_range' do
    let(:board) { double('Board') }
    let(:rook) { Rook.new([4, 4], :white)}
    subject(:move) { described_class.new(rook, [3, 3], board)}
    context 'when a move is attempted' do
      it 'provides a complete list of possible coordinates' do
        moves = move.maximum_piece_range
        expect(moves).to eq([[0, 4], [1, 4], [2, 4], [3, 4], [4, 0], [4, 1], [4, 2], [4, 3], [4, 4], [4, 5], [4, 6], [4, 7], [5, 4], [6, 4], [7, 4]])
      end
    end
  end

  describe '#exclude_own_color' do
    let(:board) { GameBoard.new }
    let(:rook) { Rook.new([4, 4], :white)}
    subject(:move) { described_class.new(rook, [3, 3], board) }
    context 'when a move is attempted' do
      it 'exempts pieces of the moving color' do
        moves = move.exclude_own_color
        expect(moves).to eq([[0, 4], [1, 4], [2, 4], [3, 4], [4, 0], [4, 1], [4, 2], [4, 3], [4, 5], [4, 6], [4, 7], [5, 4]])
      end
    end
  end

  describe '#move_checks' do
    context 'when a capture is attempted with a knight' do
      let(:knight) { Knight.new([5, 2], :white) }
      let(:board) { double('Board') }
      let(:pawn) { double('Pawn', coordinates: [3, 3], color: :black) }
      subject(:move) { described_class.new(knight, [3, 3], board) }
      before do
        allow(board).to receive(:occupied_by_own?).and_return(false)
        allow(board).to receive(:coordinate_lookup).and_return(pawn)
        allow(pawn).to receive(:coordinates=)
        allow(board).to receive(:change_piece)
        allow(move).to receive(:eliminate_blocked_options).and_return([3, 3])
      end
      it 'allows the valid capture' do
        validation = move.move_checks
        expect(validation).not_to eq(false)
      end
    end
  end
end
