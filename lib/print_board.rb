# frozen_string_literal: true

# Class that prints a board and the current position of all pieces.
class PrintBoard
  RED = 222
  WHITE = 124
  SQUARE = '  '

  def square_display(color, content = SQUARE)
    "\e[48;5;#{color}m#{content}\e[0m"
  end

  def piece_symbols
    { 'Black Knight' => '♞', 'Black Pawn' => '♟︎', 'Black Bishop' => '♝', 'Black Rook' => '♜', 'Black Queen' => '♛', 'Black King' => '♚',
      'White Knight' => '♘', 'White Pawn' => '♙', 'White Bishop' => '♗', 'White Rook' => '♖', 'White Queen' => '♕', 'White King' => '♔',
      'Unoccupied' => ' ' }
  end

  def print_board(board = GameBoard.new.all_squares)
    char_array = board.map do |row, column|
      background(row, column)
    end
    stringify(char_array)
  end

  def stringify(array)
    i = 8
    board_string = ''.dup
    while i.positive?
      board_string = "#{board_string}#{array.slice(((8 - i) * 8), 8).join} #{i} \n"
      i -= 1
    end
    puts "#{board_string} a b c d e f g h"
    "#{board_string} a b c d e f g h"
  end

  def background(row, column)
    index = (row * 8) + column
    symbol_array = GameBoard.new.all_positions
    content = symbol_array[index]
    display_symbol = piece_symbols[content]
    (row + column).even? ? square_display(RED, " #{display_symbol}") : square_display(WHITE, " #{display_symbol}")
  end
end

