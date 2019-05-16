require 'socket'
require_relative 'game'
require_relative 'grid'

class Battle_Ship

  attr_accessor :game
  
  def initialize(game = Game.new(grid = Grid.new))
    @port = 2979
    @server = TCPServer.open(@port)
    @game = game
  end

  def accept_client
    client = @server.accept
    client.puts "Welcome to BattleShip!!!"
  end

  def close
    @server.close
  end
end
