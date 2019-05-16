require 'socket'

class Battle_Ship
  
  def initialize
    @port = 2979
    @server = TCPServer.open(@port)
  end

  def accept_client
    client = @server.accept
    client.puts "Welcome to BattleShip!!!"
  end

  def close
    @server.close
  end
end
