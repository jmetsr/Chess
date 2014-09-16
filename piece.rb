class Piece

  attr_reader :color, :board
  attr_accessor :position

  def initialize(position,color,board)
    @position = position
    @color = color
    @board = board

    @board[position] = self
  end

  def take_step(pos,step)
    [pos[0] + step[0], pos[1] + step[1]]
  end

  def move_dirs
    self.class::MOVE_DIRS
  end

end