# frozen_string_literal: true

class Square
  RED = 222
  WHITE = 124
  SQUARE = '  '

  def initialize(coordinate)
    @coordinate = coordinate
    @background_color = color(*coordinate)
  end

  def color(row, column)
    (row + column).even? ? RED : WHITE
  end
end
