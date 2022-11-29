# frozen_string_literal: true

require_relative '../lib/move'
require_relative '../lib/coordinate_mapper'
require_relative '../lib/move_builder'

describe Move do
  describe '#make_move' do
    let(:fake_piece) { double('Piece', coordinates: [6, 0], color: :white) }
    let(:board) { double('GameBoard') }
    subject(:move) { described_class.new(piece: fake_piece, new_coordinates: [5, 0], board: board) }
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
        move = Move.new(piece: rook, new_coordinates: [1, 3], board: board)

        expect(board).to receive(:remove_piece)
        move.capture
      end
    end
  end
end
