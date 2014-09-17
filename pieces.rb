# coding: utf-8

require_relative 'stepping_piece'
require_relative 'sliding_piece'

class King < SteppingPiece

  MOVE_DIRS = [
    [0,1],
    [1,1],
    [1,0],
    [1,-1],
    [0,-1],
    [-1,-1],
    [-1,0],
    [-1,1],
  ]

  def symbol
    self.color == 'w' ? "\u2654" : "\u265A"
  end

end

class Queen < SlidingPiece

  MOVE_DIRS = [
    [0,1],
    [1,1],
    [1,0],
    [1,-1],
    [0,-1],
    [-1,-1],
    [-1,0],
    [-1,1],
  ]

  def symbol
    self.color == 'w' ? "\u2655" : "\u265B"
  end

end

class Rook < SlidingPiece

  MOVE_DIRS = [
    [0,1],
    [1,0],
    [0,-1],
    [-1,0]
  ]

  def symbol
    self.color == 'w' ? "\u2656" : "\u265C"
  end

end

class Bishop < SlidingPiece

  MOVE_DIRS = [
    [1,1],
    [1,-1],
    [-1,-1],
    [-1,1],
  ]

  def symbol
    self.color == 'w' ? "\u2657" : "\u265D"
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
    self.color == 'w' ? "\u2658" : "\u265E"
  end

end
