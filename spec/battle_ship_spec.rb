require 'battle_ship'
require 'socket'

describe Battle_Ship do
  
  let(:game) {double (:game)}

  before(:each) do
    @server = Battle_Ship.new(game)
    @accept = Thread.new{@server.accept_player}
  end

  after(:each) do
    @accept.join
    @server.close
  end

  def players_join_game
    client = TCPSocket.new('localhost', 2979)
    client.puts 'Player 1'
    accept = Thread.new{@server.accept_player}
    client = TCPSocket.new('localhost', 2979)
    client.puts 'Player 2'
    accept.join
  end

  it 'opens a TCPserver in port 2979 and says Welcome to BattleShip!!! to the client' do
    client = TCPSocket.new('localhost', 2979)
    client.puts 'Player 1'
    expect(client.gets.chomp).to eq('Enter your name:')
    expect(client.gets.chomp).to eq('Welcome to BattleShip Player 1!!!')
  end

  it 'allow players to position their ships' do
    players_join_game
    expect(game).to receive(:position_ships).twice
    expect(game).to receive(:play_screen).twice
    @server.position_ships
  end

  it 'loops through shooting rounds' do
    players_join_game
    expect(game).to receive(:play_screen).exactly(4).times
    expect(game).to receive(:fire_shot).twice
    expect(game).to receive(:end_game?).twice
    @server.round
  end

  it 'ends when game.end_game? eq true' do
    players_join_game
    allow(game).to receive(:play_screen)
    allow(game).to receive(:fire_shot)
    allow(game).to receive(:end_game?).and_return(true)
    expect(@server.round).to eq(:end_game)
  end
end
