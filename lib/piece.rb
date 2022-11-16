# frozen_string_literal: true

# This class provides generic behavior for any moving piece.
class Piece
  attr_reader :name, :color, :pathing
  attr_accessor :coordinates

  def initialize(coordinates, color, name = nil)
    @coordinates = coordinates
    @color = color
    @name = name
    @pathing = false
    @taken = false
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
    @pathing = true
    @taken = false
  end

  def validate_move(move)
    return validate_white(move) if color == :white

    validate_black(move)
  end

  def validate_white(move)
    return white_capture(move) unless same_column?(move)
    return true if (coordinates[0] - move[0] == 1) && same_column?(move)

    coordinates[0] == 6 && (coordinates[0] - move[0]) == 2 && same_column?(move)
  end

  def validate_black(move)
    return black_capture(move) unless same_column?(move)
    return true if (move[0] - coordinates[0] == 1) && same_column?(move)

    coordinates[0] == 1 && (move[0] - coordinates[0]) == 2 && same_column?(move)
  end

  def white_capture(move)
    coordinates[0] - move[0] == 1 && (coordinates[1] - move[1]).abs == 1
  end

  def black_capture(move)
    move[0] - coordinates[0] == 1 && (coordinates[1] - move[1]).abs == 1
  end

  def same_column?(move)
    coordinates[1] == move[1]
  end
end

# Knight behavior.
class Knight < Piece
  def initialize(coordinates, color)
    super
    @name = 'Knight'
    @pathing = false
    @taken = false
  end

  def validate_move(move)
    return true if (coordinates[0] - move[0]).abs == 2 && column_change(move) == 1

    (coordinates[0] - move[0]).abs == 1 && column_change(move) == 2
  end

  def column_change(move)
    (coordinates[1] - move[1]).abs
  end
end

# Bishop behavior.
class Bishop < Piece
  def initialize(coordinates, color)
    super
    @name = 'Bishop'
    @pathing = true
    @taken = false
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
    @pathing = true
    @taken = false
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
    @pathing = true
    @taken = false
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
    @pathing = true
    @taken = false
  end

  def validate_move(move)
    (coordinates[1] - move[1]).abs <= 1 && (coordinates[0] - move[0]).abs <= 1
  end
end
