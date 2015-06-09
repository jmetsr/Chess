require './lib/pieces/piece'

class SteppingPiece < Piece #(King or Knight)

  def moves
    #return array of all possible moves a piece can take
    possible_moves = []
    curr_pos = self.position
    #take step in all possible directions
    self.move_dirs.each { |step| possible_moves << take_step(curr_pos, step)}
    #filter out the steps that are not on the board
    possible_moves = possible_moves.select { |new_pos| self.board.on_board?(new_pos) }
    #filter out the steps that contain a piece of your color and return array
    possible_moves.select do |new_pos|
      if self.board[new_pos].nil?
        true
      else
        self.board[new_pos].color != self.color
      end
    end

  end
end