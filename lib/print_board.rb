# frozen_string_literal: true

# Class that prints a board and the current position of all pieces.
class PrintBoard
  attr_reader :white, :black

  RED = 222
  WHITE = 124
  SQUARE = '  '

  def initialize(white = Side.new('white'), black = Side.new('black'))
    @white = white
    @black = black
  end

  def square_display(color, content = SQUARE)
    "\e[48;5;#{color}m#{content}\e[0m"
  end

  def piece_symbols
    { 'Black Knight' => '♞', 'Black Pawn' => '♟︎', 'Black Bishop' => '♝', 'Black Rook' => '♜', 'Black Queen' => '♛', 'Black King' => '♚',
      'White Knight' => '♘', 'White Pawn' => '♙', 'White Bishop' => '♗', 'White Rook' => '♖', 'White Queen' => '♕', 'White King' => '♔',
      'Unoccupied' => ' ' }
  end

  def print_board(board = GameBoard.new)
    char_array = board.all_squares.map do |row, column|
      "#{background(row, column)}"
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
    (row + column).even? ? square_display(RED, symbol_lookup([row, column])) : square_display(WHITE, symbol_lookup([row, column]))
  end

  def symbol_lookup(coordinate)
    symbol = merged_locations[coordinate]&.to_s
    symbol = 'Unoccupied' if merged_locations[coordinate].nil?

    " #{piece_symbols[symbol]}"
  end

  def merged_locations
    white.coord_map.merge(black.coord_map)
  end
end
