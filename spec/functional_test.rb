require 'socket'
require_relative '../lib/computer_player.rb'

client = TCPSocket.new('localhost', 2979)
computer = ComputerPlayer.new()

get = Thread.new {
  while line = client.gets
    c = computer.input(line)
    puts line.chop
    if c != nil
      client.puts c
      puts c
    end
  end
}

get.join
