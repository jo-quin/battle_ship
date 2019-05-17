require 'socket'
require_relative 'game'
require_relative 'grid'
require_relative 'player'

class Battle_Ship
  
  def initialize(game = Game.new(grid = Grid.new))
    @port = 2979
    @server = TCPServer.open(@port)
    @game = game
    @players = []
  end

  def accept_player
    client = @server.accept
    client.puts 'Enter your name:'
    player = Player.new(client.gets.chomp , client)
    player.client.puts "Welcome to BattleShip #{player.name}!!!"
    @players << player
  end

  def position_ships
    @players.each do |player|
      opponent = @players.select { |p| p != player }[0]
      player.client.puts @game.position_ships(player, opponent)
      player.client.puts @game.play_screen(player, opponent)
    end
  end

  def close
    @server.close
  end
end
