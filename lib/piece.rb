# frozen_string_literal: true

class Piece
  attr_reader :coordinates, :name, :color

  def initialize(coordinates, color, name = nil)
    @coordinates = coordinates
    @color = color
    @name = name
  end

  def to_s
    "#{color.capitalize} #{name}"
  end
end

class Pawn < Piece
  def initialize(coordinates, color)
    super
    @name = 'Pawn'
  end
end

class Knight < Piece
  def initialize(coordinates, color)
    super
    @name = 'Knight'
  end
end

class Bishop < Piece
  def initialize(coordinates, color)
    super
    @name = 'Bishop'
  end
end

class Rook < Piece
  def initialize(coordinates, color)
    super
    @name = 'Rook'
  end
end

class Queen < Piece
  def initialize(coordinates, color)
    super
    @name = 'Queen'
  end
end

class King < Piece
  def initialize(coordinates, color)
    super
    @name = 'King'
  end
end
