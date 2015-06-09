class Piece

  ORTHOGONAL = [[0, 1], [1,  0], [0,  -1], [-1, 0]]
  DIAGONAL   = [[1, 1], [1, -1], [-1, -1], [-1, 1]]

  attr_reader :color
  attr_accessor :position, :board

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

  def dup(piece_class, new_board)
    new_piece = piece_class.new(self.position.dup, self.color, new_board)

    new_piece
  end

  def valid_moves
    #remove moves that are off the board
    #puts "all possible moves: #{self.moves}"
    valid_mvs = self.moves.select { |move| board.on_board?(move) }
    #puts "all moves on the board: #{valid_moves}"
    #remove moves that put player in check
    valid_mvs = valid_mvs.select do |move|
      dupped_board = board.dup
      dupped_board.take_move(self.position,move,dupped_board[self.position])
      !dupped_board.in_check?(self.color)
    end
    #puts "all moves that don't put player in check: #{valid_moves}"
    valid_mvs
  end

end