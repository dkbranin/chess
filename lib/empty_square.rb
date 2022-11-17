# frozen_string_literal: true

class Square
  def initialize(coordinates, occupant)
    @coordinates = coordinates
    @occupant = occupant
  end
end

class EmptySquare
  attr_reader :coordinates, :color, :name, :pathing, :taken

  def initialize(coordinates)
    @coordinates = coordinates
    @color = nil
    @name = nil
    @pathing = nil
    @taken = nil
  end

  def to_s
    'Unoccupied'
  end
end
