# frozen_string_literal: true

# This class is responsible for initially running the game.
class Game
  def initialize
    @white = Side.new('white')
    @black = Side.new('black')
    @board = GameBoard.new(white, black)
  end
end
