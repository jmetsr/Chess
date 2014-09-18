#!/usr/bin/env ruby

require_relative 'board'
require_relative 'player'
require_relative 'computer_player'

class WrongColor < StandardError
end

class Game
  attr_accessor :turn
  attr_reader :player1, :player2, :board, :player_hash

  def initialize(player1, player2)
    @player1 = player1
    @player2 = player2
    @board = Board.new
    @turn = 'w'
    @player_hash = { 'w' => player1, 'b' => player2 }
  end

  def change_color
    @turn == 'w' ? @turn = 'b' : @turn = 'w'
  end

  def run
    puts board
    until board.stalemate?(turn) || board.checkmate?(turn)
      puts "it's #{@turn}'s turn"
      begin
        move = player_hash[turn].take_turn
        raise WrongColor if board[move[0]].color != turn
        board.move(*move)
      rescue OnBoard => e
        puts "Error was #{e.message}"
        retry
      rescue NoPiece => e
        puts "#{e.message}"
        retry
      rescue WrongColor => e
        puts "#{e.message}"
        retry
      rescue InvalidEndPosition => e
        puts "#{e.message}"
        retry
      rescue InvalidMove => e
        puts "#{e.message}"
        retry
      end
      puts board
      change_color
      puts "#{turn} is in check" if board.in_check?(turn)
    end
    puts "#{turn} is in checkmate" if board.checkmate?(turn)
    puts "stalemate" if board.stalemate?(turn)
  end

end

if __FILE__ == $PROGRAM_NAME
  p1 = Player.new
  p2 = Player.new
  g = Game.new(p1,p2)
  g.run
end



