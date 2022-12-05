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
    Checkmate.new(turn.color, board).checkmate? ? game_loop : game_over
  end

  def input_loop(player = turn)
    coordinates = player.export_coordinates
    active_piece = board.coordinate_lookup(coordinates[0])
    return false unless active_piece.color == player.color

    move_checks(active_piece, coordinates[1])
  end

  def move_checks(active_piece, coordinates)
    move = Move.new(piece: active_piece, new_coordinates: coordinates, board: board)
    move.move_validation ? move.alter_board : errors[:invalid_range]
  end

  def game_over
    @turn_counter += 1
    puts "The game is over! #{turn.color} wins."
  end

  def turn
    turn_counter.even? ? player_one : player_two
  end
end
