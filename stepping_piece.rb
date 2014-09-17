require_relative 'piece'

class SteppingPiece < Piece

  def moves
    moves = []
    curr_pos = self.position

    self.move_dirs.each { |step| moves << take_step(curr_pos, step) }

    moves = moves.select { |new_pos| self.board.on_board?(new_pos) }

    moves.select { |new_pos| self.board[new_pos].nil? ? true : self.board[new_pos].color != self.color }
    #moves.select { |new_pos| self.board[new_pos].nil? ? true : self.board[new_pos].color != self.color }

  end
end