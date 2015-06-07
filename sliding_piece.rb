
require './piece'

class SlidingPiece < Piece #(Queen, Bishop, or Rook)

  def moves
    #debugger

    #return array of all possible moves a piece can take
    possible_moves = []
    #loop through directions
    move_dirs.each do |step|
      curr_pos = self.position
      moves_in_direction = []
      #take steps in direction until you reach end of board or hit a piece
      while true
        new_pos = take_step(curr_pos,step)
        on_board = self.board.on_board?(new_pos)
        last_step_empty = self.board[moves_in_direction.last] == nil
        curr_step_empty = self.board[new_pos].nil?
        unless curr_step_empty
          diff_color_piece = self.board[new_pos].color != self.color
        end

        if on_board && last_step_empty
          if curr_step_empty || diff_color_piece
            moves_in_direction << new_pos
            curr_pos = new_pos
          else
            break
          end
        else
          break
        end

      end
      possible_moves += moves_in_direction
    end

    possible_moves

  end

end