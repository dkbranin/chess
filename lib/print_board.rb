# frozen_string_literal: true

# Class that prints a board and the current position of all pieces.
class PrintBoard
  attr_reader :piece_status, :all_coords

  RED = 222
  WHITE = 124
  SQUARE = '  '

  def initialize(all_coords = GameBoard.new.all_squares, piece_status = GameBoard.new.merged_locations)
    @all_coords = all_coords
    @piece_status = piece_status
  end

  def print_board
    char_array = all_coords.map do |row, column|
      background(row, column)
    end
    stringify(char_array)
  end

  private

  def square_display(color, content = SQUARE)
    "\e[48;5;#{color}m#{content}\e[0m"
  end

  def coord_lookup(current_pieces = piece_status)
    new_hash = {}
    current_pieces.each_value do |piece|
      new_hash[piece.coordinates] = piece
    end
    new_hash
  end

  def piece_symbols
    { 'Black Knight' => '♞', 'Black Pawn' => '♟︎', 'Black Bishop' => '♝', 'Black Rook' => '♜', 'Black Queen' => '♛', 'Black King' => '♚',
      'White Knight' => '♘', 'White Pawn' => '♙', 'White Bishop' => '♗', 'White Rook' => '♖', 'White Queen' => '♕', 'White King' => '♔',
      'Unoccupied' => ' ' }
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
    symbol = coord_lookup[coordinate]&.to_s
    symbol = 'Unoccupied' if coord_lookup[coordinate].nil?

    " #{piece_symbols[symbol]}"
  end
end
