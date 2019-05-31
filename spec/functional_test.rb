require 'socket'
require_relative '../lib/computer_player.rb'

client = TCPSocket.new('localhost', 2979)
computer = ComputerPlayer.new(client = client)

get = Thread.new {
  while line = computer.client.gets
    computer.client.puts computer.input(line)
    puts line.chop
  end
}

get.join
