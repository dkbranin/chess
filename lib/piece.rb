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

  def current_row_minus_proposed_row(move)
    coordinates[0] - move.coordinates[0]
  end

  def proposed_row_minus_current_row(move)
    move.coordinates[0] - coordinates[0]
  end

  def column_difference(move)
    coordinates[1] - move.coordinates[1]
  end
end

# Pawn behavior.
class Pawn < Piece
  def initialize(coordinates, color)
    super
    @name = 'Pawn'
  end

  def validate_move(move)
    return false if same_column?(move) && !move.name.nil?
    return validate_white(move) if color == :white

    validate_black(move)
  end

  def validate_white(move)
    return white_capture(move) if capture?(move)
    return true if current_row_minus_proposed_row(move) == 1 && same_column?(move)

    coordinates[0] == 6 && current_row_minus_proposed_row(move) == 2 && same_column?(move)
  end

  def validate_black(move)
    return black_capture(move) if capture?(move)
    return true if proposed_row_minus_current_row(move) == 1 && same_column?(move)

    coordinates[0] == 1 && proposed_row_minus_current_row(move) == 2 && same_column?(move)
  end

  def white_capture(move)
    current_row_minus_proposed_row(move) == 1 && column_difference(move).abs == 1
  end

  def black_capture(move)
    proposed_row_minus_current_row(move) == 1 && column_difference(move).abs == 1
  end

  def capture?(move)
    same_column?(move) == false && !move.name.nil? && move.color != color
  end

  def same_column?(move)
    coordinates[1] == move.coordinates[1]
  end
end

# Knight behavior.
class Knight < Piece
  def initialize(coordinates, color)
    super
    @name = 'Knight'
  end

  def validate_move(move)
    return true if current_row_minus_proposed_row(move).abs == 2 && column_change(move) == 1

    current_row_minus_proposed_row(move).abs == 1 && column_change(move) == 2
  end

  def column_change(move)
    column_difference(move).abs
  end
end

# Bishop behavior.
class Bishop < Piece
  def initialize(coordinates, color)
    super
    @name = 'Bishop'
  end

  def validate_move(move)
    current_row_minus_proposed_row(move).abs == column_difference(move).abs
  end
end

# Rook behavior.
class Rook < Piece
  def initialize(coordinates, color)
    super
    @name = 'Rook'
  end

  def validate_move(move)
    coordinates[0] == move.coordinates[0] || coordinates[1] == move.coordinates[1]
  end
end

# Queen behavior.
class Queen < Piece
  def initialize(coordinates, color)
    super
    @name = 'Queen'
  end

  def validate_move(move)
    return true if current_row_minus_proposed_row(move).abs == column_difference(move).abs

    coordinates[0] == move.coordinates[0] || coordinates[1] == move.coordinates[1]
  end
end

# King behavior.
class King < Piece
  def initialize(coordinates, color)
    super
    @name = 'King'
  end

  def validate_move(move)
    base_move(move)
  end

  def base_move(move)
    column_difference(move).abs <= 1 && current_row_minus_proposed_row(move).abs <= 1
  end
end
