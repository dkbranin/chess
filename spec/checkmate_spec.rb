# frozen_string_literal: true

require_relative '../lib/messaging'
require_relative '../lib/coordinate_mapper'
require_relative '../lib/checkmate'
require_relative '../lib/move'
require_relative '../lib/move_builder'

describe Checkmate do
  describe '#checkmate?' do
    let(:board) { GameBoard.new }
    let(:rook) { Rook.new([4, 4], :white) }

    def proceed(coordinates, new_coords, board)
      piece = board.coordinate_lookup(coordinates)
      Move.new(piece: piece, new_coordinates: new_coords, board: board).alter_board
    end

    subject(:matecheck) { described_class.new(:white, board) }
    context 'when the game begins' do
      it 'is not checkmate' do
        checkmate_status = matecheck.checkmate?
        expect(checkmate_status).to be(false)
      end
    end
    context 'when moves have been made but the board is not in checkmate' do
      subject(:matecheck) { described_class.new(:white, board) }
      before do
        proceed([6, 5], [5, 5], board)
        proceed([1, 4], [2, 4], board)
      end
      it 'is not checkmate' do
        p board
        checkmate_status = matecheck.checkmate?
        expect(checkmate_status).to be(false)
      end
    end
    context 'when a side is in check but it is not checkmate' do
      subject(:move) { described_class.new(:black, board) }
      before do
        proceed([6, 4], [4, 4], board)
        proceed([1, 3], [3, 3], board)
        proceed([6, 2], [5, 2], board)
        proceed([1, 5], [2, 5], board)
        proceed([7, 3], [4, 0], board)
      end
      it 'is not checkmate' do
        p board
        checkmate_status = matecheck.checkmate?
        expect(checkmate_status).to be(false)
      end
    end
    context 'when a side cannot escape check' do
      subject(:matecheck) { described_class.new(:white, board) }
      before do
        proceed([6, 5], [5, 5], board)
        proceed([1, 4], [2, 4], board)
        proceed([6, 6], [4, 6], board)
        proceed([0, 3], [4, 7], board)
      end
      it 'is checkmate' do
        board.print_board
        checkmate_status = matecheck.checkmate?
        expect(checkmate_status).to be(true)
      end
    end
  end
end
