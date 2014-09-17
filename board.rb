require_relative 'pieces'
require_relative 'pawn'

class Board

  pieces = [ Rook, Knight, Bishop, Queen, King, Bishop, Knight, Rook ]
  positions = []
  # cycles through rows 0,1,6,7 and creates array of positions of those rows
  [0,1,6,7].each do |row|
    positions += Array.new(8){Array.new(1,row)}.map.with_index{|el,index|el<<index}
  end
  #simplify creation of starting pieces by using arrays of constants
  POSITIONS = positions
  COLORS = Array.new(16,"w") + Array.new(16,"b")
  PIECE_CLASSES = pieces + Array.new(8,Pawn) + Array.new(8,Pawn) + pieces

  attr_accessor :board, :wk, :bk

  def self.create_board
    Array.new(8) { Array.new(8,nil) }
  end

  def create_pieces
    PIECE_CLASSES.each_with_index do |piece_class,index|
      if piece_class == King
        COLORS[index] == 'w' ? @wk = piece_class.new([0, 4], 'w', self) : @bk = piece_class.new([7, 4], 'b', self)
      else
        piece_class.new(POSITIONS[index], COLORS[index], self)
      end
    end
  end

  def initialize
    @board = Board.create_board
    create_pieces
  end

  def move(start_pos,end_pos)
    piece = self[start_pos]
    end_pos_object = self[end_pos]
    #check if start and end pos are on board
    unless on_board?(start_pos) && on_board?(end_pos)
      raise ArgumentError.new "You entered a position that's not on the board"
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
    piece.valid_moves.nil? ? move_is_valid = false : move_is_valid = piece.valid_moves.include?(end_pos)
    #move_is_valid = piece.valid_moves.include?(end_pos) unless valid_moves.nil?
    unless move_is_valid
      raise ArgumentError.new "Your piece cannot move like that"
    end

    take_move(start_pos,end_pos,piece)

  end

  def take_move(start_pos,end_pos,piece)
    #update board
    self[start_pos] = nil
    self[end_pos] = piece
    #update pieces postion
    piece.position = end_pos
  end

  def on_board?(pos)
    pos[0].between?(0,7) && pos[1].between?(0,7)
  end

  def in_check?(color)
    in_check = false
    pieces = board.flatten.select { |el| !el.nil? }
    color == 'w' ? king_pos = @wk.position : king_pos = @bk.position

    pieces.each { |piece| in_check = true if piece.moves.include?(king_pos) }
    in_check
  end

  def checkmate?(color)
    #if player is in check
   # p board.flatten.select { |piece| !piece.nil? && piece.color == color }. map {|piece| piece.class }
  #  board.flatten.select { |piece| !piece.nil? && piece.color == color }.each do | piece |
      #puts "#{piece.class}: #{piece.valid_moves}, #{piece.valid_moves.empty?}"
  #  end

    in_check?(color) &&
    #and player has no valid moves
    board.flatten.select { |piece| !piece.nil? && piece.color == color }.all? do | piece |
      piece.valid_moves.empty?
    end

  end

  def stalemate?(turn_color)
    #if player is not in check
    !in_check?(turn_color) &&
    #and player has no valid moves
    board.flatten.select { |piece| !piece.nil? && piece.color == turn_color }.all? do | piece |
      piece.valid_moves.empty?
    end
  end

  def render
    puts "  " + (0..7).to_a.join("  ")
    board.each_with_index do |row,indx|
      puts "#{indx} " + row.map { |cell|
        cell.nil? ? '_' : cell.symbol
      }.join("  ")
    end
    nil
  end

  def chess_dup
    new_board = self.dup #dup board object
    #dup board instance variable (Array of Arrays of pieces objects)
    new_board.board = self.board.dup
    new_board.board = new_board.board.map { |row| row.dup }
    #dup pieces objects (flatten array, and dup each element)
    new_board.board.flatten.each do |piece|
      unless piece.nil?
        new_piece = piece.piece_dup(new_board) #dup pieces, positions, board
        new_board[piece.position] = new_piece
      end
    end
    #dup wk and bk
    new_board.wk = new_board[wk.position]
    new_board.bk = new_board[bk.position]

    new_board
  end

  def [](pos)
    @board[pos[0]][pos[1]] unless pos.nil?
  end

  def []=(pos,object)
    @board[pos[0]][pos[1]] = object
  end

  def inspect
    ""
  end

end