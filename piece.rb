class Piece

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

  def piece_dup(new_board)
    new_piece = self.dup
    #dup piece position
    new_piece.position = self.position.dup
    #set piece boards to duped board
    new_piece.board = new_board

    new_piece
  end

  def valid_moves
    #remove moves that are off the board
    valid_moves = self.moves.select { |move| board.on_board?(move) }
    #remove moves that put player in check
    valid_moves.select do |move|
      dupped_board = board.chess_dup
      dupped_board.take_move(self.position,move,self)
      !dupped_board.in_check?(self.color)
    end
  end

end