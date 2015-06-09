require './pieces'
require './pawn'
require 'colorize'
class Board

  PIECE_CLASSES = [ Rook, Knight, Bishop, Queen, King, Bishop, Knight, Rook ]

  attr_reader :board
  attr_accessor :wk, :bk

  def self.create_board
    Array.new(8) { Array.new(8,nil) }
  end

  def initialize(setup = true)
    @board = Board.create_board
    setup_board if setup
  end

  def move(start_pos,end_pos)
    piece = self[start_pos]
    end_pos_object = self[end_pos]
    #check if start and end pos are on board
    unless on_board?(start_pos) && on_board?(end_pos)
      raise OnBoard.new "You entered a position that's not on the board"
    end
    #check if start has a piece
    if piece.nil?
      raise NoPiece.new "There is no piece on #{start_pos} to move"
    end
    #check if end is nil (or same color piece)
    unless end_pos_object.nil? || end_pos_object.color != piece.color
      raise InvalidEndPosition.new "Invalid end position #{end_pos}"
    end
    #checking pieces move method for array of valid moves
    piece.valid_moves.nil? ? move_is_valid = false : move_is_valid = piece.valid_moves.include?(end_pos)
    #move_is_valid = piece.valid_moves.include?(end_pos) unless valid_moves.nil?
    unless move_is_valid
      raise InvalidMove.new "Your piece cannot move like that"
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
    #player is in check
    in_check?(color) &&
    #and player has no valid moves
    same_color_pieces(color).all? { | piece | piece.valid_moves.empty? }
  end

  def stalemate?(color)
    #player is not in check
    !in_check?(color) &&
    #and player has no valid moves
    same_color_pieces(color).all? { | piece | piece.valid_moves.empty? }
  end

  def same_color_pieces(color) #get all same color pieces on the board
    board.flatten.compact.select { |piece| piece.color == color }
  end

  def to_s #puts board
    top_row = "  " + ('a'..'h').to_a.join("  ") +"\n"
    rows = ""
    board.each_with_index do |row, indx|
      index = "#{ indx + 1 } "

      row_string = row.map { |cell| cell.nil? ? "❑".colorize(:blue) : cell.symbol }.join("  ")

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
    @board[pos[0]][pos[1]] unless pos.nil? || @board[pos[0]].nil?
  end

  def []=(pos,object)
    @board[pos[0]][pos[1]] = object
  end

  def inspect
    ""
  end

  private

  def setup_board
    create_pieces('w') #create white pieces row
    create_pieces('b') #create black pieces row
    #create pawns
    8.times { |column| Pawn.new([1, column], 'w', self) }
    8.times { |column| Pawn.new([6, column], 'b', self) }
  end

  def create_pieces(color)
    if color == 'w'
      PIECE_CLASSES.each_with_index do |piece_class, col| #cycle through pieces
        ref = piece_class.new([0, col], 'w', self) #create piece
        @wk = ref if piece_class == King #set reference to king
      end
    else #create black pieces
      PIECE_CLASSES.each_with_index do |piece_class, col|
        ref = piece_class.new([7, col], 'b', self)
        @bk = ref if piece_class == King
      end
    end
  end

end

class OnBoard < StandardError
end

class NoPiece < StandardError
end

class InvalidEndPosition < StandardError
end

class InvalidMove < StandardError
end