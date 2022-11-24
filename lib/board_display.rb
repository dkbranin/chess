# frozen_string_literal: true
require_relative '../lib/coordinate_mapper'

# Class that prints a board and the current position of all pieces.
class BoardDisplay
  include CoordinateMapper
  attr_reader :piece_status, :all_coords

  RED = 222
  WHITE = 124
  SQUARE = '  '

  def initialize(piece_status = GameBoard.new.board_state, all_coords = all_coordinates)
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

  def coord_lookup(coords, array = piece_status)
    array.find { |piece| piece.coordinates == coords }
  end

  def piece_symbols
    { 'Black Knight' => "\e[38;5;#243m♞\e[0m", 'Black Pawn' => "\e[38;5;#243m♟︎\e[0m", 'Black Bishop' => "\e[38;5;#243m♝\e[0m",
      'Black Rook' => "\e[38;5;#243m♜\e[0m", 'Black Queen' => "\e[38;5;#243m♛\e[0m", 'Black King' => "\e[38;5;#243m♚\e[0m",
      'White Knight' => "\e[38;5;#81m♞\e[0m", 'White Pawn' => "\e[38;5;#81m♟︎\e[0m", 'White Bishop' => "\e[38;5;#81m♝\e[0m",
      'White Rook' => "\e[38;5;#81m♜\e[0m", 'White Queen' => "\e[38;5;#81m♛\e[0m", 'White King' => "\e[38;5;#81m♚\e[0m",
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
    symbol = coord_lookup(coordinate)&.to_s
    symbol = 'Unoccupied' if coord_lookup(coordinate).nil?

    " #{piece_symbols[symbol]}"
  end
end
