# frozen_string_literal: true

require_relative '../lib/player'

describe Player do
  describe '#valid_input?' do
    subject(:player) { described_class.new }
    context 'when valid input is provided' do
      it 'returns true' do
        good_move = player.valid_input?('d4e3')
        expect(good_move).to eq(true)
      end
    end
    context 'when input is too long' do
      it 'returns false' do
        bad_move = player.valid_input?('d3d2d3')
        expect(bad_move).to eq(false)
      end
    end
    context 'when input is too short' do
      it 'returns false' do
        bad_move = player.valid_input?('d3')
        expect(bad_move).to eq(false)
      end
    end
    context 'when input contains invalid characters' do
      it 'returns false' do
        bad_move = player.valid_input?('d9d3')
        expect(bad_move).to eq(false)
      end
    end
  end

  describe '#export_coordinates' do
    subject(:player) { described_class.new }
    context 'when receiving player input' do
      before do
        allow(player).to receive(:validate_input).and_return('a1b2')
      end
      it 'returns a 2d array of coordinates' do
        array = player.export_coordinates
        expect(array).to eq([[7, 0], [6, 1]])
      end
    end
  end
end
