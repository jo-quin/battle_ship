require 'socket'
require_relative 'game'
require_relative 'grid'
require_relative 'player'
require_relative 'termiro'
require 'date'

class Battle_Ship
  include Termiro
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
    client.puts clear_screen
    client.puts draw('main_title')
    sleep 2
    client.puts 'Enter your name:'
    player = Player.new(client.gets.chomp , client)
    player.client.puts "Welcome to BattleShip #{player.name}!!!"
    @players << player
  end

  def multiplayer_menu
    @players[0].client.puts "Enter 'f' to play against a friend or 'c' to play against the computer:"
    choice = @players[0].client.gets.chomp.downcase
    thread1 = Thread.new {accept_player}
    sleep 0.5
    if choice == 'c'
      @players[0].client.puts 'Loading computer...'
      thread2 = Thread.new {system("ruby #{Dir.pwd}/lib/computer_player.rb")}
    else
      @players[0].client.puts 'Waiting for your friend...'
    end
    thread1.join
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
      unless ARGV[0] == 'test' then sleep(2) end
      scroll_down(player)
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

  def scroll_down(player)
    5.times { player.client.puts "\n" }
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
  if ARGV[0] == 'test'
    2.times do server.accept_player end
    server.position_ships
    loop {
      if server.round == :end_game
        break
      end
    }
    open("#{Dir.pwd}/spec/average_rounds.txt", 'a') do |f| 
      f.puts "#{DateTime.now.strftime}: #{server.rounds} rounds."
    end
  else
    server.accept_player
    server.multiplayer_menu
    server.position_ships
    loop {
      if server.round == :end_game
        break
      end
    }
  end
  server.close
end
