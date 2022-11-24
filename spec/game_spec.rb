# frozen_string_literal: true

require_relative '../lib/game'

describe Game do
  describe '#input_loop' do
    subject(:game) { described_class.new }
    context 'when a single move is placed' do
      before do
        allow(game.player_one).to receive(:gets).and_return('d2d4').once
      end
      it 'alters the board' do
        expect { game.input_loop }.to change { game.board.state }
      end
    end

    context 'when the move is invalid' do
      before do
        allow(game.player_one).to receive(:gets).and_return('d2d5').once
      end
      it 'does not alter the board' do
        expect { game.input_loop }.not_to change { game.board.state }
      end
    end
  end
end
