class Player
  #creates a hash to map board position indices (0,1) to user input (a1)
  row_names    = ('1'..'8').to_a.zip((0..7).to_a).to_h
  column_names = ('a'..'h').to_a.zip((0..7).to_a).to_h
  MOVE_HASH = row_names.merge(column_names)

  def take_turn #game calls players take_turn method
    p "enter your move"
    move = gets.chomp
    until move =~ /\A[a-h][1-8] [a-h][1-8]\Z/ #check for correct format
      p "Incorrect format, enter your move like this: ex: (a2 a3)"
      move = gets.chomp
    end
      move = move.split #convert users input to an array
      #map the array to the correct board indices
      move = move.map { |pos| [MOVE_HASH[pos[1]], MOVE_HASH[pos[0]]] }
  end
end