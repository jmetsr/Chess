require_relative 'pieces'
require_relative 'pawn'

class Board

  pieces = [ Rook, Knight, Bishop, Queen, King, Bishop, Knight, Rook ]
  positions = []
  # cycles through rows 0,1,6,7 and creates array of positions of those rows
  [0,1,6,7].each do |row|
    positions += Array.new(8) { Array.new(1,row) }.map.with_index{ |el,index|el<<index }
  end
  #simplify creation of starting pieces by using arrays of constants
  POSITIONS = positions
  COLORS = Array.new(16,"w") + Array.new(16,"b")
  PIECE_CLASSES = pieces + Array.new(8,Pawn) + Array.new(8,Pawn) + pieces

  attr_reader :board
  attr_accessor :wk, :bk

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

  def initialize(setup_pieces = true)
    @board = Board.create_board
    create_pieces if setup_pieces
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

    pieces.each do |piece|
      in_check = true if piece.moves.include?(king_pos)
    end
    in_check
  end

  def checkmate?(color)
    in_check?(color) &&
    #and player has no valid moves
    board.flatten.select { |piece| !piece.nil? && piece.color == color
    }.all? do | piece |
      piece.valid_moves.empty?
    end

  end

  def stalemate?(turn_color)
    #if player is not in check
    !in_check?(turn_color) &&
    #and player has no valid moves
    board.flatten.compact.select { |piece| piece.color == turn_color }.all? do | piece |
      piece.valid_moves.empty?
    end

  end

  def to_s
    top_row = "  " + ('a'..'h').to_a.join("  ") +"\n"
    rows = ""
    board.each_with_index do |row, indx|
      index = "#{ indx + 1 } "
      row_string = row.map { |cell| cell.nil? ? '-' : cell.symbol }.join("  ")
      rows += index + row_string + "\n"
    end
    top_row + rows
  end

  def dup
    new_board = Board.new(false) #Create new board, do not add pieces
    #dup pieces objects (flatten array, and dup each element)
    self.board.flatten.compact.each { |piece| piece.dup(piece.class, new_board) }
    #dup white king and black king (to use later in #checkmate?)
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