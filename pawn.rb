class Pawn < Piece

  def symbol
    self.color == 'w' ? "\u2659" : "\u265F"
  end

end