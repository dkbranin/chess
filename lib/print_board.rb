# frozen_string_literal: true

# Class that prints a board and the current position of all pieces.
class PrintBoard
  RED = 222
  WHITE = 124
  SQUARE = '  '

  def background(color, content = SQUARE)
    "\e[48;5;#{color}m#{content}\e[0m"
  end

  def empty_board
    i = 8
    board_string = ''.dup
    while i > 0
      board_string = "#{board_string}#{board_row(i) * 4} #{i} \n"
      i -= 1
    end
    puts "#{board_string} a b c d e f g h"
    "#{board_string} a b c d e f g h"
  end

  def print_board
    empty_board
  end

  def board_row(row_number)
    if row_number.even?
      background(RED) + background(WHITE)
    else
      background(WHITE) + background(RED)
    end
  end
end
