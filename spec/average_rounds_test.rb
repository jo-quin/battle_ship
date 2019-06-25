require 'date'

10.times do
  t1 = Thread.new {system("ruby #{Dir.pwd}/lib/battle_ship.rb test")}
  sleep 0.5
  t2 = Thread.new {system("ruby #{Dir.pwd}/lib/computer_player.rb")}
  t3 = Thread.new {system("ruby #{Dir.pwd}/spec/functional_test.rb")}

  t1.join
  t2.join
  t3.join
end

rounds = 0

open("#{Dir.pwd}/spec/average_rounds.txt", 'r') do |file| 
  file.each_line do |line|
    rounds += line.split(' ')[1].to_i
  end
end

open("#{Dir.pwd}/spec/average_rounds.txt", 'w') do |f| 
  f.puts
end

average_rounds = rounds/10.to_f

open("#{Dir.pwd}/spec/logs/average_rounds_log.txt", 'a') do |f| 
    f.puts
    f.puts "\u001b[101m#{DateTime.now.strftime}: AVERAGE ROUNDS: #{average_rounds}\u001b[0m"
    f.puts
  end

system("cat #{Dir.pwd}/spec/logs/average_rounds_log.txt")
