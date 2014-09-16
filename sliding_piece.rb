require_relative 'piece'


class SlidingPiece < Piece

  def moves
    moves = []


    #loop through move_dirs
    move_dirs.each do |step|
      dir_moves = []
      curr_pos = self.position
      valid = true
      while valid
        new_pos = take_step(curr_pos,step)
        p dir_moves
        if self.board.on_board?(new_pos) && self.board[dir_moves.last] == nil
          dir_moves << new_pos
          curr_pos = new_pos
        else
          valid = false
        end
      end
      moves += dir_moves
    end

    moves

    #keep taking step from move_dirs until reach end of board || hit a piece
    #add to array
  end





end