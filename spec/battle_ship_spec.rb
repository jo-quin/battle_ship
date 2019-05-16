require 'battle_ship'
require 'socket'

describe Battle_Ship do
  before(:each) do
    @server = Battle_Ship.new
    Thread.new{@server.accept_client}
  end

  after(:each) do
    @server.close
  end

  it 'opens a TCPserver in port 2979 and says Welcome to BattleShip!!! to the client' do
    client = TCPSocket.new('localhost', 2979)
    expect(client.gets.chomp).to eq('Welcome to BattleShip!!!')
  end
end
