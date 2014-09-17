class Pawn < Piece

  WHITE_MOVES = [[1, 0], [1, 1], [1, -1]]
  BLACK_MOVES = [[-1, 0], [-1, 1], [1, -1]]

  def symbol
    self.color == 'w' ? "\u2659" : "\u265F"
  end

  def moves
    moves = []
    curr_pos = self.position
    self.color == 'w' ? potential_moves = WHITE_MOVES : potential_moves = BLACK_MOVES

    potential_moves.each do |step|
      new_pos = take_step(curr_pos, step)
      if step.include?(0) #straight up or down (not attacking)
        moves << new_pos if self.board[new_pos].nil?
      else
        moves << new_pos if !self.board[new_pos].nil? &&
        self.board[new_pos].color != self.color
      end

    end
    moves
  end

end