# frozen_string_literal: true

require_relative 'messaging'

# This class is responsible for initially running the game.
class Game
  include Messaging
  attr_reader :board, :player_one, :player_two, :turn_counter

  def initialize
    @board = GameBoard.new
    @player_one = Player.new(:white)
    @player_two = Player.new(:black)
    @turn_counter = 0
  end

  def game_loop
    board.print_board
    input_loop == errors[:invalid_range] ? game_loop : turn_end
  end

  def turn_end(determiner: true)
    return if determiner == false

    @turn_counter += 1
    game_loop
  end

  def input_loop(player = turn)
    coordinates = player.export_coordinates
    active_piece = board.coordinate_lookup(coordinates[0])
    return false unless active_piece.color == player.color

    move_checks(active_piece, coordinates[1])
  end

  def move_checks(active_piece, coordinates)
    move = Move.new(active_piece, coordinates, board)
    move.move_validation ? move.alter_board : errors[:invalid_range]
  end

  def turn
    turn_counter.even? ? player_one : player_two
  end
end

# Currently the input loop is difficult to test, because it calls itself with no end.
# It should be able to break under various conditions -- user quits, asked for in a test
# Or if an error message is called
