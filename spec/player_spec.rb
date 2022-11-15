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

  describe '#input_to_coords' do
    subject(:player) { described_class.new }
    context 'when the coordinate is a1' do
      it 'returns [7, 0]' do
        coordinate = player.input_to_coords('a1')
        expect(coordinate).to eq([7, 0])
      end
    end
    context 'when the coordinate is h8' do
      it 'returns [0, 7]' do
        coordinate = player.input_to_coords('h8')
        expect(coordinate).to eq([0, 7])
      end
    end
  end

  describe '#first_coordinate' do
    subject(:player) { described_class.new }
    context 'when the coordinate is a1h8' do
      it 'returns [7, 0]' do
        coordinate = player.first_coordinate('a1h8')
        expect(coordinate).to eq([7, 0])
      end
    end
  end

  describe '#second_coordinate' do
    subject(:player) { described_class.new }
    context 'when the coordinate is a1h8' do
      it 'returns [0, 7]' do
        coordinate = player.second_coordinate('a1h8')
        expect(coordinate).to eq([0, 7])
      end
    end
  end
end
