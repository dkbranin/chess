# frozen_string_literal: true

# This class determines the squares between a piece's current position and its attempted move.
class Path
  def path_choice(start, finish)
    return horizontal(start, finish) if start[0] == finish[0]
    return vertical(start, finish) if start[1] == finish[1]

    diagonal(start, finish)
  end

  def horizontal(start, finish)
    array = []
    min_column = [start[1], finish[1]].min
    max_column = [start[1], finish[1]].max
    min_column.upto(max_column) { |column| array.push([start[0], column]) }
    array.reverse! if start[1] > finish[1]
    array.shift
    array
  end

  def vertical(start, finish)
    array = []
    min_row = [start[0], finish[0]].min
    max_row = [start[0], finish[0]].max
    min_row.upto(max_row) { |row| array.push([row, start[1]]) }
    array.reverse! if start[0] > finish[0]
    array.shift
    array
  end

  def diagonal(start, finish)
    (start[0] + start[1]) == (finish[0] + finish[1]) ? upward_diagonal(start, finish) : downward_diagonal(start, finish)
  end

  def upward_diagonal(start, finish)
    array = []
    lowest_row = [start[0], finish[0]].min
    highest_column = [start[1], finish[1]].max
    i = 0
    while i <= (start[0] - finish[0]).abs
      array.push([lowest_row + i, highest_column - i])
      i += 1
    end
    array.reverse! if start[0] > finish[0]
    array.shift
    array
  end

  def downward_diagonal(start, finish)
    array = []
    lowest_row = [start[0], finish[0]].min
    lowest_column = [start[1], finish[1]].min
    i = 0
    while i <= (start[0] - finish[0]).abs
      array.push([lowest_row + i, lowest_column + i])
      i += 1
    end
    array.reverse! if start[0] > finish[0]
    array.shift
    array
  end
end
