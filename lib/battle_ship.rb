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
    puts "\n Battle_Ship server started at port #{@port} \n"
  end

  def accept_player
    client = @server.accept
    client.puts 'Enter your name:'
    player = Player.new(client.gets.chomp , client)
    player.client.puts "Welcome to BattleShip #{player.name}!!!"
    @players << player
  end

  def position_ships # print waiting for player2 if player1
    @players.each do |player|
      opponent = @players.select { |p| p != player }[0]
      player.client.puts @game.position_ships(player, opponent)
      player.client.puts @game.play_screen(player, opponent)
    end
  end

  def round
    @players.each do |player|
      opponent = @players.select { |p| p != player }[0]
      player.client.puts "#{player.name} your turn!"
      player.client.puts @game.play_screen(player, opponent)
      player.client.puts @game.fire_shot(player, opponent)
      player.client.puts @game.play_screen(player, opponent)
      player.client.puts "#{opponent.name}'s' turn."
    end
  end

  def close
    @server.close
  end
end

if __FILE__ == $0
  server = Battle_Ship.new
  2.times do server.accept_player end
  server.position_ships
  loop {
    server.round
  }
  server.close
end
