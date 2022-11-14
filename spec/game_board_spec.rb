# frozen_string_literal: true

require_relative '../lib/game_board'

describe GameBoard do
  describe '#all_squares' do
    subject(:game_board) { described_class.new }
    it 'generates an array of coordinates for each row and column' do
      game_array = game_board.all_squares
      expect(game_array).to eq(
        [[0, 0], [0, 1], [0, 2], [0, 3], [0, 4], [0, 5], [0, 6], [0, 7],
         [1, 0], [1, 1], [1, 2], [1, 3], [1, 4], [1, 5], [1, 6], [1, 7],
         [2, 0], [2, 1], [2, 2], [2, 3], [2, 4], [2, 5], [2, 6], [2, 7],
         [3, 0], [3, 1], [3, 2], [3, 3], [3, 4], [3, 5], [3, 6], [3, 7],
         [4, 0], [4, 1], [4, 2], [4, 3], [4, 4], [4, 5], [4, 6], [4, 7],
         [5, 0], [5, 1], [5, 2], [5, 3], [5, 4], [5, 5], [5, 6], [5, 7],
         [6, 0], [6, 1], [6, 2], [6, 3], [6, 4], [6, 5], [6, 6], [6, 7],
         [7, 0], [7, 1], [7, 2], [7, 3], [7, 4], [7, 5], [7, 6], [7, 7]]
      )
    end
  end

  describe '#all_positions' do
    subject(:game_board) { described_class.new }
    it 'should not be nil' do
      array_with_pieces = game_board.all_positions
      expect(array_with_pieces).not_to eq(nil)
    end
    context 'when the piece is occupied' do
      it 'returns the name of the piece' do
        black_knight = game_board.all_positions[9]
        expect(black_knight).to eq('Black Pawn')
      end
      it 'returns the name of the piece' do
        black_knight = game_board.all_positions[6]
        expect(black_knight).to eq('Black Knight')
      end
    end
  end
end
