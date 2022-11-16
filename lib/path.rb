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
    trim_array(array)
  end

  def vertical(start, finish)
    array = []
    min_row = min_row(start, finish)
    max_row = [start[0], finish[0]].max
    min_row.upto(max_row) { |row| array.push([row, start[1]]) }
    array.reverse! if start[0] > finish[0]
    trim_array(array)
  end

  def diagonal(start, finish)
    (start[0] + start[1]) == (finish[0] + finish[1]) ? upward_diagonal(start, finish) : downward_diagonal(start, finish)
  end

  def upward_diagonal(start, finish)
    array = []
    lowest_row = min_row(start, finish)
    highest_column = [start[1], finish[1]].max
    i = 0
    while i <= (start[0] - finish[0]).abs
      array.push([lowest_row + i, highest_column - i])
      i += 1
    end
    array.reverse! if start[0] > finish[0]
    trim_array(array)
  end

  def downward_diagonal(start, finish)
    array = []
    lowest_row = min_row(start, finish)
    lowest_column = [start[1], finish[1]].min
    i = 0
    while i <= (start[0] - finish[0]).abs
      array.push([lowest_row + i, lowest_column + i])
      i += 1
    end
    array.reverse! if start[0] > finish[0]
    trim_array(array)
  end

  def trim_array(array)
    array.shift
    array.pop
    array
  end

  def min_row(start, finish)
    [start[0], finish[0]].min
  end
end
