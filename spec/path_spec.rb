# frozen_string_literal: true

require_relative '../lib/path'

describe Path do
  describe '#path_choice' do
    subject(:path) { described_class.new }
    context 'when there is a horizontal path' do
      it 'returns an array of all traversed squares' do
        horizontal_path = path.path_choice([4, 0], [4, 7])
        expect(horizontal_path).to eq([[4, 1], [4, 2], [4, 3], [4, 4], [4, 5], [4, 6], [4, 7]])
      end
    end
    context 'when there is a vertical path' do
      it 'returns an array of all traversed squares' do
        vertical_path = path.path_choice([5, 5], [3, 5])
        expect(vertical_path).to eq([[4, 5], [3, 5]])
      end
    end
    context 'when there is an upward diagonal path' do
      it 'returns an array of all traversed squares' do
        upward_diagonal_path = path.path_choice([4, 3], [6, 1])
        expect(upward_diagonal_path).to eq([[5, 2], [6, 1]])
      end
    end
    context 'when there is a downward diagonal path' do
      it 'returns an array of all traversed squares' do
        downward_diagonal_path = path.path_choice([6, 1], [8, 3])
        expect(downward_diagonal_path).to eq([[7, 2], [8, 3]])
      end
    end
  end
  describe '#horizontal' do
    subject(:path) { described_class.new }
    context 'when there are multiple squares in the path' do
      it 'returns an array of all traversed squares' do
        horizontal_path = path.horizontal([4, 0], [4, 7])
        expect(horizontal_path).to eq([[4, 1], [4, 2], [4, 3], [4, 4], [4, 5], [4, 6], [4, 7]])
      end
    end
  end
  describe '#vertical' do
    subject(:path) { described_class.new }
    context 'when there are multiple squares in the path' do
      it 'returns an array of all traversed squares' do
        vertical_path = path.vertical([0, 4], [7, 4])
        expect(vertical_path).to eq([[1, 4], [2, 4], [3, 4], [4, 4], [5, 4], [6, 4], [7, 4]])
      end
    end
  end
  describe '#upward_diagonal' do
    subject(:path) { described_class.new }
    context 'when there are multiple squares in the path' do
      it 'returns an array of all traversed squares' do
        upward_diagonal_path = path.upward_diagonal([4, 4], [7, 1])
        expect(upward_diagonal_path).to eq([[5, 3], [6, 2], [7, 1]])
      end
      it 'returns an array of all traversed squares in the correct direction' do
        upward_diagonal_path = path.upward_diagonal([7, 1], [4, 4])
        expect(upward_diagonal_path).to eq([[6, 2], [5, 3], [4, 4]])
      end
    end
  end
  describe '#downward_diagonal' do
    subject(:path) { described_class.new }
    context 'when there are multiple squares in the path' do
      it 'returns an array of all traversed squares' do
        downward_diagonal_path = path.downward_diagonal([4, 4], [7, 7])
        expect(downward_diagonal_path).to eq([[5, 5], [6, 6], [7, 7]])
      end
      it 'returns an array of all traversed squares in the correct direction' do
        downward_diagonal_path = path.downward_diagonal([7, 7], [4, 4])
        expect(downward_diagonal_path).to eq([[6, 6], [5, 5], [4, 4]])
      end
    end
  end
end
