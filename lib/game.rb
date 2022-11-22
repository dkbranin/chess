# frozen_string_literal: true

# This class is responsible for initially running the game.
class Game
  attr_reader :board, :player_one, :player_two
  attr_accessor :turn_counter

  def initialize
    @board = GameBoard.new
    @player_one = Player.new(:white)
    @player_two = Player.new(:black)
    @turn_counter = 0
  end

  def game_loop
    board.print_board
    input_loop ? turn_end : game_loop
  end

  def turn_end
    @turn_counter += 1
    game_loop
  end

  def input_loop(player = turn)
    coords = player.export_coordinates
    active_piece = board.coordinate_lookup(coords[0])
    return false if active_piece.nil?
    return false unless active_piece.color == player.color

    Move.new(active_piece, coords[1], board).move_checks
  end

  def turn
    turn_counter.even? ? player_one : player_two
  end
end
