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

  def validate_move(move)
    return validate_white(move) if color == :white
    validate_black(move)
  end

  def validate_white(move)
    return true if (coordinates[0] - move[0] == 1) && (coordinates[1] == move[1])

    coordinates[0] == 6 && (coordinates[0] - move[0]) == 2 && (coordinates[1] == move[1])
  end

  def validate_black(move)
    return true if (move[0] - coordinates[0] == 1) && (coordinates[1] == move[1])

    coordinates[0] == 1 && (move[0] - coordinates[0]) == 2 && coordinates[1] == move[1]
  end
end

# Knight behavior.
class Knight < Piece
  def initialize(coordinates, color)
    super
    @name = 'Knight'
  end

  def validate_move(move)
    return true if (coordinates[0] - move[0]).abs == 2 && (coordinates[1] - move[1]).abs == 1

    (coordinates[0] - move[0]).abs == 1 && (coordinates[1] - move[1]).abs == 2
  end
end

# Bishop behavior.
class Bishop < Piece
  def initialize(coordinates, color)
    super
    @name = 'Bishop'
  end

  def validate_move(move)
    (coordinates[0] - move[0]).abs == (coordinates[1] - move[1]).abs
  end
end

# Rook behavior.
class Rook < Piece
  def initialize(coordinates, color)
    super
    @name = 'Rook'
  end

  def validate_move(move)
    coordinates[0] == move[0] || coordinates[1] == move[1]
  end
end

# Queen behavior.
class Queen < Piece
  def initialize(coordinates, color)
    super
    @name = 'Queen'
  end

  def validate_move(move)
    return true if (coordinates[0] - move[0]).abs == (coordinates[1] - move[1]).abs

    coordinates[0] == move[0] || coordinates[1] == move[1]
  end
end

# King behavior.
class King < Piece
  def initialize(coordinates, color)
    super
    @name = 'King'
  end

  def validate_move(move)
    (coordinates[1] - move[1]).abs <= 1 && (coordinates[0] - move[0]).abs <= 1
  end
end
