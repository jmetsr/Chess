class Pawn < Piece

  WHITE_MOVES = [[ 1, 1], [1, -1], [ 1, 0], [ 2, 0]]
  BLACK_MOVES = [[-1, 1], [1, -1], [-1, 0], [-2, 0]]

  def symbol
    self.color == 'w' ? "♙" : "♟"
  end

  def moves
    moves = []
    curr_pos = self.position
    self.color == 'w' ? potential_moves = WHITE_MOVES : potential_moves = BLACK_MOVES

    potential_moves.each do |step|
      new_pos = take_step(curr_pos, step)

      if step.include?(0) && !(step.include?(2) || step.include?(-2))
        if self.board[new_pos].nil?
          moves << new_pos
        else
          break #there is a piece in front of the pawn and thus cannot move 2
        end
      elsif step.include?(2) || step.include?(-2)
        if self.board[new_pos].nil? && (self.position[0] == 1 || self.position[0] == 6)
          moves << new_pos
        end
      else
        moves << new_pos if !self.board[new_pos].nil? &&
        self.board[new_pos].color != self.color
      end

    end
    moves
  end

end