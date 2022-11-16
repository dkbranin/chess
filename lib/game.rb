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

  def game_loop(player = player_one)
    board.print_board
    coords = player.export_coordinates
    active_piece = board.coordinate_lookup(coords[0])
    player.invalid_input if Move.new(active_piece, coords[1], board, player.color).move_checks == false
    @turn_counter += 1
    game_loop(turn)
  end

  def turn
    turn_counter.even? ? player_one : player_two
  end
end
