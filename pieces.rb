
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

  def move_dirs
    MOVE_DIRS
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

  def move_dirs
    MOVE_DIRS
  end

end

class Rook < SlidingPiece

  MOVE_DIRS = [
    [0,1],
    [1,0],
    [0,-1],
    [-1,0]
  ]

  def move_dirs
    MOVE_DIRS
  end

end

class Bishop < SlidingPiece

  MOVE_DIRS = [
    [1,1],
    [1,-1],
    [-1,-1],
    [-1,1],
  ]

  def move_dirs
    MOVE_DIRS
  end

end

class Knight < SteppingPiece

  MOVE_DIRS = [
    [1,2],
    [2,1],
    [2,-1],
    [1,-2],
    [-1,-2],
    [-2,-1],
    [-2,1],
    [-1,2]
  ]

  def move_dirs
    MOVE_DIRS
  end

end