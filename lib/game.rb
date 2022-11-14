class Game
  def initialize
    @white = Side.new('white')
    @black = Side.new('black')
    @board = GameBoard.new(white, black)
  end
end