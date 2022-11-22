# frozen_string_literal: true

require_relative '../lib/game_board'
require_relative '../lib/empty_square'

describe GameBoard do
  describe '#print_board' do
    subject(:game_board) { described_class.new }
    context 'when there have been no moves' do
      it 'returns a string of the pieces in their original positions' do
        board_string = game_board.print_board
        expect(board_string).to eq(
          "\
\e[48;5;222m \e[38;5;#243m♜\e[0m\e[0m\e[48;5;124m \e[38;5;#243m♞\e[0m\e[0m\e[48;5;222m \e[38;5;#243m♝\e[0m\e[0m\e[48;5;124m \e[38;5;#243m♛\e[0m\e[0m\e[48;5;222m \e[38;5;#243m♚\e[0m\e[0m\e[48;5;124m \e[38;5;#243m♝\e[0m\e[0m\e[48;5;222m \e[38;5;#243m♞\e[0m\e[0m\e[48;5;124m \e[38;5;#243m♜\e[0m\e[0m 8 \n\
\e[48;5;124m \e[38;5;#243m♟︎\e[0m\e[0m\e[48;5;222m \e[38;5;#243m♟︎\e[0m\e[0m\e[48;5;124m \e[38;5;#243m♟︎\e[0m\e[0m\e[48;5;222m \e[38;5;#243m♟︎\e[0m\e[0m\e[48;5;124m \e[38;5;#243m♟︎\e[0m\e[0m\e[48;5;222m \e[38;5;#243m♟︎\e[0m\e[0m\e[48;5;124m \e[38;5;#243m♟︎\e[0m\e[0m\e[48;5;222m \e[38;5;#243m♟︎\e[0m\e[0m 7 \n\
\e[48;5;222m  \e[0m\e[48;5;124m  \e[0m\e[48;5;222m  \e[0m\e[48;5;124m  \e[0m\e[48;5;222m  \e[0m\e[48;5;124m  \e[0m\e[48;5;222m  \e[0m\e[48;5;124m  \e[0m 6 \n\
\e[48;5;124m  \e[0m\e[48;5;222m  \e[0m\e[48;5;124m  \e[0m\e[48;5;222m  \e[0m\e[48;5;124m  \e[0m\e[48;5;222m  \e[0m\e[48;5;124m  \e[0m\e[48;5;222m  \e[0m 5 \n\
\e[48;5;222m  \e[0m\e[48;5;124m  \e[0m\e[48;5;222m  \e[0m\e[48;5;124m  \e[0m\e[48;5;222m  \e[0m\e[48;5;124m  \e[0m\e[48;5;222m  \e[0m\e[48;5;124m  \e[0m 4 \n\
\e[48;5;124m  \e[0m\e[48;5;222m  \e[0m\e[48;5;124m  \e[0m\e[48;5;222m  \e[0m\e[48;5;124m  \e[0m\e[48;5;222m  \e[0m\e[48;5;124m  \e[0m\e[48;5;222m  \e[0m 3 \n\
\e[48;5;222m \e[38;5;#81m♟︎\e[0m\e[0m\e[48;5;124m \e[38;5;#81m♟︎\e[0m\e[0m\e[48;5;222m \e[38;5;#81m♟︎\e[0m\e[0m\e[48;5;124m \e[38;5;#81m♟︎\e[0m\e[0m\e[48;5;222m \e[38;5;#81m♟︎\e[0m\e[0m\e[48;5;124m \e[38;5;#81m♟︎\e[0m\e[0m\e[48;5;222m \e[38;5;#81m♟︎\e[0m\e[0m\e[48;5;124m \e[38;5;#81m♟︎\e[0m\e[0m 2 \n\
\e[48;5;124m \e[38;5;#81m♜\e[0m\e[0m\e[48;5;222m \e[38;5;#81m♞\e[0m\e[0m\e[48;5;124m \e[38;5;#81m♝\e[0m\e[0m\e[48;5;222m \e[38;5;#81m♛\e[0m\e[0m\e[48;5;124m \e[38;5;#81m♚\e[0m\e[0m\e[48;5;222m \e[38;5;#81m♝\e[0m\e[0m\e[48;5;124m \e[38;5;#81m♞\e[0m\e[0m\e[48;5;222m \e[38;5;#81m♜\e[0m\e[0m 1 \n\
 a b c d e f g h"
        )
      end
    end
  end

  describe '#change_piece' do
    subject(:game_board) { described_class.new }
    context 'when a piece is changed' do
      it 'prints a board with the piece in the new position' do
        board_string = game_board.change_piece([6, 1], [5, 1])
        expect(board_string).to eq(
          "\
\e[48;5;222m \e[38;5;#243m♜\e[0m\e[0m\e[48;5;124m \e[38;5;#243m♞\e[0m\e[0m\e[48;5;222m \e[38;5;#243m♝\e[0m\e[0m\e[48;5;124m \e[38;5;#243m♛\e[0m\e[0m\e[48;5;222m \e[38;5;#243m♚\e[0m\e[0m\e[48;5;124m \e[38;5;#243m♝\e[0m\e[0m\e[48;5;222m \e[38;5;#243m♞\e[0m\e[0m\e[48;5;124m \e[38;5;#243m♜\e[0m\e[0m 8 \n\
\e[48;5;124m \e[38;5;#243m♟︎\e[0m\e[0m\e[48;5;222m \e[38;5;#243m♟︎\e[0m\e[0m\e[48;5;124m \e[38;5;#243m♟︎\e[0m\e[0m\e[48;5;222m \e[38;5;#243m♟︎\e[0m\e[0m\e[48;5;124m \e[38;5;#243m♟︎\e[0m\e[0m\e[48;5;222m \e[38;5;#243m♟︎\e[0m\e[0m\e[48;5;124m \e[38;5;#243m♟︎\e[0m\e[0m\e[48;5;222m \e[38;5;#243m♟︎\e[0m\e[0m 7 \n\
\e[48;5;222m  \e[0m\e[48;5;124m  \e[0m\e[48;5;222m  \e[0m\e[48;5;124m  \e[0m\e[48;5;222m  \e[0m\e[48;5;124m  \e[0m\e[48;5;222m  \e[0m\e[48;5;124m  \e[0m 6 \n\
\e[48;5;124m  \e[0m\e[48;5;222m  \e[0m\e[48;5;124m  \e[0m\e[48;5;222m  \e[0m\e[48;5;124m  \e[0m\e[48;5;222m  \e[0m\e[48;5;124m  \e[0m\e[48;5;222m  \e[0m 5 \n\
\e[48;5;222m  \e[0m\e[48;5;124m  \e[0m\e[48;5;222m  \e[0m\e[48;5;124m  \e[0m\e[48;5;222m  \e[0m\e[48;5;124m  \e[0m\e[48;5;222m  \e[0m\e[48;5;124m  \e[0m 4 \n\
\e[48;5;124m  \e[0m\e[48;5;222m \e[38;5;#81m♟︎\e[0m\e[0m\e[48;5;124m  \e[0m\e[48;5;222m  \e[0m\e[48;5;124m  \e[0m\e[48;5;222m  \e[0m\e[48;5;124m  \e[0m\e[48;5;222m  \e[0m 3 \n\
\e[48;5;222m \e[38;5;#81m♟︎\e[0m\e[0m\e[48;5;124m  \e[0m\e[48;5;222m \e[38;5;#81m♟︎\e[0m\e[0m\e[48;5;124m \e[38;5;#81m♟︎\e[0m\e[0m\e[48;5;222m \e[38;5;#81m♟︎\e[0m\e[0m\e[48;5;124m \e[38;5;#81m♟︎\e[0m\e[0m\e[48;5;222m \e[38;5;#81m♟︎\e[0m\e[0m\e[48;5;124m \e[38;5;#81m♟︎\e[0m\e[0m 2 \n\
\e[48;5;124m \e[38;5;#81m♜\e[0m\e[0m\e[48;5;222m \e[38;5;#81m♞\e[0m\e[0m\e[48;5;124m \e[38;5;#81m♝\e[0m\e[0m\e[48;5;222m \e[38;5;#81m♛\e[0m\e[0m\e[48;5;124m \e[38;5;#81m♚\e[0m\e[0m\e[48;5;222m \e[38;5;#81m♝\e[0m\e[0m\e[48;5;124m \e[38;5;#81m♞\e[0m\e[0m\e[48;5;222m \e[38;5;#81m♜\e[0m\e[0m 1 \n\
 a b c d e f g h"
        )
      end
    end
  end

  describe '#occupied_by_own?' do
    subject(:game_board) { described_class.new }
    let(:current_player) { double('Player') }
    before do
      allow(current_player).to receive(:color).and_return(:white)
    end
    context 'when the square is occupied by the moving player color' do
      it 'returns true' do
        validation = game_board.occupied_by_own?([6, 1], current_player.color)
        expect(validation).to eq(true)
      end
    end
    context 'when the square is occupied by the opposing player color' do
      it 'returns false' do
        validation = game_board.occupied_by_own?([0, 1], current_player.color)
        expect(validation).to eq(false)
      end
    end
    context 'when the square is not occupied' do
      it 'returns false' do
        validation = game_board.occupied_by_own?([4, 4], current_player.color)
        expect(validation).to eq(false)
      end
    end
  end
end
