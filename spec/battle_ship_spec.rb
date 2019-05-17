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

  it 'opens a TCPserver in port 2979 and says Welcome to BattleShip!!! to the client' do
    client = TCPSocket.new('localhost', 2979)
    client.puts 'Player 1'
    expect(client.gets.chomp).to eq('Enter your name:')
    expect(client.gets.chomp).to eq('Welcome to BattleShip Player 1!!!')
  end

  it 'allow players to position their ships' do
    client = TCPSocket.new('localhost', 2979)
    client.puts 'Player 1'
    accept = Thread.new{@server.accept_player}
    client = TCPSocket.new('localhost', 2979)
    client.puts 'Player 2'
    accept.join
    expect(game).to receive(:position_ships).twice
    expect(game).to receive(:play_screen).twice
    @server.position_ships
  end

  it 'loops through shooting rounds'

  it 'ends when all ships from a player are destroyed'
end
