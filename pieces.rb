# coding: utf-8

require './stepping_piece'
require './sliding_piece'

class King < SteppingPiece

  MOVE_DIRS = Piece::ORTHOGONAL + Piece::DIAGONAL

  def symbol
    self.color == 'w' ? "♔" : "♚"
  end

end

class Queen < SlidingPiece

  MOVE_DIRS = Piece::ORTHOGONAL + Piece::DIAGONAL

  def symbol
    self.color == 'w' ? "♕" : "♛"
  end

end

class Rook < SlidingPiece

  MOVE_DIRS = Piece::ORTHOGONAL

  def symbol
    self.color == 'w' ? "♖" : "♜"
  end

end

class Bishop < SlidingPiece

  MOVE_DIRS = Piece::DIAGONAL

  def symbol
    self.color == 'w' ? "♗" : "♝"
  end

end

class Knight < SteppingPiece

  MOVE_DIRS = [
    [ 1,  2],
    [ 2,  1],
    [ 2, -1],
    [ 1, -2],
    [-1, -2],
    [-2, -1],
    [-2,  1],
    [-1,  2]
  ]

  def symbol
    self.color == 'w' ? "♘" : "♞"
  end

end
