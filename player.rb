class Player

  MOVE_HASH = ('1'..'8').to_a.zip((0..7).to_a).to_h.merge(('a'..'h').to_a.zip((0..7).to_a).to_h)

  def take_turn
    p "enter your move"
    move = gets.chomp
    until move =~ /\A[a-h][1-8] [a-h][1-8]\Z/
      p "Incorrect format, enter your move like this: ex: (a2 a3)"
      move = gets.chomp
    end
      move = move.split
      move = move.map { |pos| [MOVE_HASH[pos[1]], MOVE_HASH[pos[0]]] }
  end
end