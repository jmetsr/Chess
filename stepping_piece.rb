require_relative 'piece'

class SteppingPiece < Piece
  def moves
    moves = []
    curr_pos = self.postion

    self.move_dirs.each { |step| moves << take_step(curr_pos, step) }

    moves
  end
end