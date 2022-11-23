# frozen_string_literal: true

require_relative '../lib/piece'

describe King do
  describe '#validate_move' do
    subject(:king) { described_class.new([4, 4], :white) }
    context 'when the move is valid' do
      it 'returns true' do
        validity = king.validate_move(EmptySquare.new([4, 5]))
        expect(validity).to eq(true)
      end
    end
    context 'when the move is invalid' do
      it 'returns false' do
        validity = king.validate_move(EmptySquare.new([6, 6]))
        expect(validity).to eq(false)
      end
    end
  end
end

describe Knight do
  describe '#validate_move' do
    subject(:knight) { described_class.new([4, 4], :white) }
    context 'when the move is valid' do
      it 'returns true' do
        validity = knight.validate_move(EmptySquare.new([5, 2]))
        expect(validity).to eq(true)
      end
    end
    context 'when the move is invalid' do
      it 'returns false' do
        validity = knight.validate_move(EmptySquare.new([4, 5]))
        expect(validity).to eq(false)
      end
    end
  end
end

describe Bishop do
  describe '#validate_move' do
    subject(:bishop) { described_class.new([4, 4], :white) }
    context 'when the move is valid' do
      it 'returns true on the upward diagnonal' do
        validity = bishop.validate_move(EmptySquare.new([7, 7]))
        expect(validity).to eq(true)
      end
      it 'returns true on the downward diagonal' do
        validity = bishop.validate_move(EmptySquare.new([7, 1]))
        expect(validity).to eq(true)
      end
    end
    context 'when the move is invalid' do
      it 'returns false' do
        validity = bishop.validate_move(EmptySquare.new([6, 4]))
        expect(validity).to eq(false)
      end
    end
  end
end

describe Pawn do
  describe '#validate_move' do
    subject(:pawn) { described_class.new([6, 1], :white) }
    context 'when the move is valid' do
      it 'returns true when moving one square' do
        validity = pawn.validate_move(EmptySquare.new([5, 1]))
        expect(validity).to eq(true)
      end
      it 'returns true when moving two squares' do
        validity = pawn.validate_move(EmptySquare.new([4, 1]))
        expect(validity).to eq(true)
      end
    end
    context 'when the move is invalid' do
      it 'returns false' do
        validity = pawn.validate_move(EmptySquare.new([6, 4]))
        expect(validity).to eq(false)
      end
    end
  end
end
