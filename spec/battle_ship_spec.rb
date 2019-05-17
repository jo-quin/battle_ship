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
    client.puts 'Jose'
    expect(client.gets.chomp).to eq('Enter your name:')
    expect(client.gets.chomp).to eq('Welcome to BattleShip Jose!!!')
  end

  it 'assign clients to player 1 and player 2'

  it 'allow players to position their ships'

  it 'loops through shooting rounds'

  it 'ends when all ships from a player are destroyed'
end
