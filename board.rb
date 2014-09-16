require_relative 'pieces'

class Board

  attr_reader :board

  def self.create_board
    Array.new(8) { Array.new(8,nil) }
  end

  def initialize
    @board = Board.create_board
  end

  def move(start_pos,end_pos)
    piece = self[start_pos]
    end_pos_object = self[end_pos]
    #check if start and end pos are on board
    unless on_board?(start_pos) && on_board?(end_pos)
      raise ArgumentError.new "Your positions are not on the board"
    end
    #check if start has a piece
    if piece.nil?
      raise ArgumentError.new "There is no piece on #{start_pos} to move"
    end
    #check if end is nil (or same color piece)
    unless end_pos_object.nil? || end_pos_object.color != piece.color
      raise ArgumentError.new "Invalid end position #{end_pos}"
    end
    #checking pieces move method for array of valid moves
    move_is_valid = piece.moves.include?(end_pos)
    unless move_is_valid
      raise ArgumentError.new "Your piece cannot move like that"
    end
    #update board
    self[start_pos] = nil
    self[end_pos] = piece
  end

  def on_board?(pos)
    pos[0].between?(0,7) && pos[1].between?(0,7)
  end

  def [](pos)
    @board[pos[0]][pos[1]] unless pos.nil?
  end

  def []=(pos,object)
    @board[pos[0]][pos[1]] = object
  end

end