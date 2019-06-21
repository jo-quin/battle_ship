require 'socket'
require_relative 'game'
require_relative 'grid'
require_relative 'player'
require 'date'

class Battle_Ship

  attr_reader :rounds
  
  def initialize(game = Game.new(grid = Grid.new))
    @port = 2979
    @server = TCPServer.open(@port)
    @game = game
    @players = []
    puts "\n Battle_Ship server started at port #{@port} \n"
    @rounds = 0
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
      player.client.puts clear_screen
      opponent = @players.select { |p| p != player }[0]
      player.client.puts "#{player.name} your turn!"
      player.client.puts @game.play_screen(player, opponent)
      player.client.puts @game.fire_shot(player, opponent)
      # sleep(2)
      player.client.puts clear_screen
      player.client.puts @game.play_screen(player, opponent)
      if @game.end_game?(player, opponent) == true
        return winner(player)
      end
      player.client.puts "#{opponent.name}'s turn."
    end
    @rounds += 1
  end

  def close
    @server.close
  end

  private

  def clear_screen
    return "\e[H\e[2J"
  end

  def winner(player)
    @players.each do |p|
      p.client.puts "#{player.name.upcase} WINS!!!"
    end
    return :end_game
  end
end

if __FILE__ == $0
  server = Battle_Ship.new
  2.times do server.accept_player end
  server.position_ships
  loop {
    if server.round == :end_game
      break
    end
  }
  open('/Users/student/scripts/battle_ship/spec/average_rounds.txt', 'a') do |f| 
    f.puts "#{DateTime.now.strftime}: #{server.rounds} rounds."
  end
  server.close
end
