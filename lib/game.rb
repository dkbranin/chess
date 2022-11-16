# frozen_string_literal: true

# This class is responsible for initially running the game.
class Game
  attr_reader :board

  def initialize
    @board = GameBoard.new
    @player_one = Player.new(:white)
    @player_two = Player.new(:black)
  end
end
