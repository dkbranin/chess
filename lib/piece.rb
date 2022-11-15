# frozen_string_literal: true

# This class provides generic behavior for any moving piece.
class Piece
  attr_reader :name, :color
  attr_accessor :coordinates

  def initialize(coordinates, color, name = nil)
    @coordinates = coordinates
    @color = color
    @name = name
  end

  def to_s
    "#{color.capitalize} #{name}"
  end

  def move(new_coordinates)
    self.coordinates = new_coordinates
  end
end

# Pawn behavior.
class Pawn < Piece
  def initialize(coordinates, color)
    super
    @name = 'Pawn'
  end
end

# Knight behavior.
class Knight < Piece
  def initialize(coordinates, color)
    super
    @name = 'Knight'
  end
end

# Bishop behavior.
class Bishop < Piece
  def initialize(coordinates, color)
    super
    @name = 'Bishop'
  end
end

# Rook behavior.
class Rook < Piece
  def initialize(coordinates, color)
    super
    @name = 'Rook'
  end
end

# Queen behavior.
class Queen < Piece
  def initialize(coordinates, color)
    super
    @name = 'Queen'
  end
end

# King behavior.
class King < Piece
  def initialize(coordinates, color)
    super
    @name = 'King'
  end
end
