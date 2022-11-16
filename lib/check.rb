# frozen_string_literal: true

class Check
  attr_reader :king

  def initialize(king, board = GameBoard.new)
    @king = king
    @board = board
  end

  def linear_check_possibilities
    [check_up, check_down, check_left, check_right]
  end

  def diagonal_check_possibilities
    [check_up_left, check_down_left, check_up_right, check_down_right]
  end

  def check_up
    coords = king.coordinates
    i = coords[0] - 1
    build_decreasing_array([i, coords[1]], i)
  end

  def check_down
    coords = king.coordinates
    i = coords[0] + 1
    build_increasing_array([i, coords[1]], i)
  end

  def check_left
    coords = king.coordinates
    i = coords[1] - 1
    build_decreasing_array([coords[0], i], i)
  end

  def check_right
    coords = king.coordinates
    i = coords[1] + 1
    build_increasing_array([coords[0], i], i)
  end

  def check_up_left
    array = []
    coords = king.coordinates
    # rows are decreasing, columns are decreasing
    i = 1
    while coords[0] - i >= 0 && coords[1] - i >= 0
      array.push([coords[0] - i, coords[1] - i])
      i += 1
    end
  end

  def check_down_right
    array = []
    coords = king.coordinates
    # rows are increasing, columns are increasing
    i = 1
    while coords[0] + i <= 7 && coords[1] + i <= 7
      array.push([coords[0] + i, coords[1] + i])
      i += 1
    end
  end

  def check_up_right
    array = []
    coords = king.coordinates
    # rows are decreasing, columns are increasing
    i = 1
    while coords[0] - i >= 0 && coords[1] + i <= 7
      array.push([coords[0] - i, coords[1] + i])
      i += 1
    end
  end

  def check_down_left
    array = []
    coords = king.coordinates
    # rows are increasing, columns are decreasing
    i = 1
    while coords[0] + i <= 7 && coords[1] - i >= 0
      array.push([coords[0] + i, coords[1] - i])
      i += 1
    end
  end

  def build_increasing_array(coord_template, first_value)
    array = []
    i = first_value
    while i <= 7
      array.push(coord_template)
      i += 1
    end
  end

  def build_decreasing_array(coord_template, first_value)
    array = []
    i = first_value
    while i >= 0
      array.push(coord_template)
      i -= 1
    end
  end

  # Needs to be called to determine if a particular board state is check
  # However, it needs to reject potential moves if they would cause a moving player to enter check, or would not cause the moving player to exit check
end