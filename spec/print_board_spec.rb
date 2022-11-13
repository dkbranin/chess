require_relative '../lib/print_board'

describe PrintBoard do
  describe '#empty_board' do
    subject(:game_board) { described_class.new }
    it 'prints an empty game board' do
      board = game_board.empty_board
      expect(board).to eq(
        "\
\e[48;5;222m  \e[0m\e[48;5;124m  \e[0m\e[48;5;222m  \e[0m\e[48;5;124m  \e[0m\e[48;5;222m  \e[0m\e[48;5;124m  \e[0m\e[48;5;222m  \e[0m\e[48;5;124m  \e[0m 8 \n\
\e[48;5;124m  \e[0m\e[48;5;222m  \e[0m\e[48;5;124m  \e[0m\e[48;5;222m  \e[0m\e[48;5;124m  \e[0m\e[48;5;222m  \e[0m\e[48;5;124m  \e[0m\e[48;5;222m  \e[0m 7 \n\
\e[48;5;222m  \e[0m\e[48;5;124m  \e[0m\e[48;5;222m  \e[0m\e[48;5;124m  \e[0m\e[48;5;222m  \e[0m\e[48;5;124m  \e[0m\e[48;5;222m  \e[0m\e[48;5;124m  \e[0m 6 \n\
\e[48;5;124m  \e[0m\e[48;5;222m  \e[0m\e[48;5;124m  \e[0m\e[48;5;222m  \e[0m\e[48;5;124m  \e[0m\e[48;5;222m  \e[0m\e[48;5;124m  \e[0m\e[48;5;222m  \e[0m 5 \n\
\e[48;5;222m  \e[0m\e[48;5;124m  \e[0m\e[48;5;222m  \e[0m\e[48;5;124m  \e[0m\e[48;5;222m  \e[0m\e[48;5;124m  \e[0m\e[48;5;222m  \e[0m\e[48;5;124m  \e[0m 4 \n\
\e[48;5;124m  \e[0m\e[48;5;222m  \e[0m\e[48;5;124m  \e[0m\e[48;5;222m  \e[0m\e[48;5;124m  \e[0m\e[48;5;222m  \e[0m\e[48;5;124m  \e[0m\e[48;5;222m  \e[0m 3 \n\
\e[48;5;222m  \e[0m\e[48;5;124m  \e[0m\e[48;5;222m  \e[0m\e[48;5;124m  \e[0m\e[48;5;222m  \e[0m\e[48;5;124m  \e[0m\e[48;5;222m  \e[0m\e[48;5;124m  \e[0m 2 \n\
\e[48;5;124m  \e[0m\e[48;5;222m  \e[0m\e[48;5;124m  \e[0m\e[48;5;222m  \e[0m\e[48;5;124m  \e[0m\e[48;5;222m  \e[0m\e[48;5;124m  \e[0m\e[48;5;222m  \e[0m 1 \n\
 a b c d e f g h"
      )
    end
  end

  describe '#print_board' do
    subject(:occupied_board) { described_class.new }
    context 'when no moves have been made' do
      it 'prints a board with pieces in their original positions' do
        board = occupied_board.print_board
        expect(board).to eq(
          "\
\e[48;5;222m ♜\e[0m\e[48;5;124m ♞\e[0m\e[48;5;222m ♝\e[0m\e[48;5;124m ♛\e[0m\e[48;5;222m ♚\e[0m\e[48;5;124m ♝\e[0m\e[48;5;222m ♞\e[0m\e[48;5;124m ♜\e[0m 8 \n\
\e[48;5;124m ♟︎\e[0m\e[48;5;222m ♟︎\e[0m\e[48;5;124m ♟︎\e[0m\e[48;5;222m ♟︎\e[0m\e[48;5;124m ♟︎\e[0m\e[48;5;222m ♟︎\e[0m\e[48;5;124m ♟︎\e[0m\e[48;5;222m ♟︎\e[0m 7 \n\
\e[48;5;222m  \e[0m\e[48;5;124m  \e[0m\e[48;5;222m  \e[0m\e[48;5;124m  \e[0m\e[48;5;222m  \e[0m\e[48;5;124m  \e[0m\e[48;5;222m  \e[0m\e[48;5;124m  \e[0m 6 \n\
\e[48;5;124m  \e[0m\e[48;5;222m  \e[0m\e[48;5;124m  \e[0m\e[48;5;222m  \e[0m\e[48;5;124m  \e[0m\e[48;5;222m  \e[0m\e[48;5;124m  \e[0m\e[48;5;222m  \e[0m 5 \n\
\e[48;5;222m  \e[0m\e[48;5;124m  \e[0m\e[48;5;222m  \e[0m\e[48;5;124m  \e[0m\e[48;5;222m  \e[0m\e[48;5;124m  \e[0m\e[48;5;222m  \e[0m\e[48;5;124m  \e[0m 4 \n\
\e[48;5;124m  \e[0m\e[48;5;222m  \e[0m\e[48;5;124m  \e[0m\e[48;5;222m  \e[0m\e[48;5;124m  \e[0m\e[48;5;222m  \e[0m\e[48;5;124m  \e[0m\e[48;5;222m  \e[0m 3 \n\
\e[48;5;222m ♙\e[0m\e[48;5;124m ♙\e[0m\e[48;5;222m ♙\e[0m\e[48;5;124m ♙\e[0m\e[48;5;222m ♙\e[0m\e[48;5;124m ♙\e[0m\e[48;5;222m ♙\e[0m\e[48;5;124m ♙\e[0m 2 \n\
\e[48;5;124m  ♖\e[0m\e[48;5;222m ♘\e[0m\e[48;5;124m ♗\e[0m\e[48;5;222m ♕\e[0m\e[48;5;124m ♔\e[0m\e[48;5;222m ♗\e[0m\e[48;5;124m ♘\e[0m\e[48;5;222m ♖\e[0m 1 \n\
 a b c d e f g h"
        )
      end
    end
  end
end
