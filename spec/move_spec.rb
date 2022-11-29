# frozen_string_literal: true

require_relative '../lib/move'
require_relative '../lib/coordinate_mapper'
require_relative '../lib/move_builder'

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

  describe '#capture' do
    context 'when a capture is attempted' do
      it 'sends a message to the board to remove the piece' do
        rook = Rook.new([5, 3], :white)
        board = GameBoard.new
        move = Move.new(rook, [1, 3], board)

        expect(board).to receive(:remove_piece)
        move.capture
      end
    end
  end

  describe '#checkmate?' do
    let(:board) { GameBoard.new }
    let(:rook) { Rook.new([4, 4], :white) }

    def proceed(coordinates, new_coords, board)
      piece = board.coordinate_lookup(coordinates)
      Move.new(piece, new_coords, board).alter_board
    end

    subject(:move) { described_class.new(rook, [3, 3], board) }
    context 'when the game begins' do
      it 'is not checkmate' do
        checkmate_status = move.checkmate?
        expect(checkmate_status).to be(false)
      end
    end
    context 'when a side cannot escape check' do
      subject(:move) { described_class.new(board.coordinate_lookup([6, 1]), [6, 2], board) }
      before do
        proceed([6, 5], [5, 5], board)
        proceed([1, 4], [2, 4], board)
        proceed([6, 6], [4, 6], board)
        proceed([0, 3], [4, 7], board)
      end
      it 'is checkmate' do
        p board
        checkmate_status = move.checkmate?
        expect(checkmate_status).to be(true)
      end
    end
  end
end
