class Piece

  attr_reader :position, :color, :board

  def initialize(position,color,board)
    @position = position
    @color = color
    @board = board
  end

  def take_step(pos,step)
    [pos[0] + step[0], pos[1] + step[1]]
  end

end