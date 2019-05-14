require_relative 'grid'
require_relative 'player'

class Game
  attr_reader :ships_coordinates
  SHIPS = {
    carrier: 5,
    battleship: 4,
    cruiser: 3,
    submarine: 3,
    destroyer: 2
  }

  def initialize(grid = Grid.new)
    @grid = grid
  end

  def ships
    string = ''
    SHIPS.each do |ship, length|
      string += "#{ship.capitalize} Length: #{length}\n"
    end
    puts string
  end

  def position_ships_instructions
    puts 'To position your ships on the grid enter starting coordinates (A to J and 1 to 10) and vertical or horizontal.
EXAMPLE: B5 vertical'
  end

  def position_ships(player, opponent)
    SHIPS.each do |ship, length|
      puts @grid.print_grid1(player.ships_coordinates,opponent.shots_coordinates)
      begin
        input_coordinates(ship, length, player)
      rescue
        puts 'Wrong coordinates! Try again.'
        retry
      end
    end
  end

  def play_screen(player, opponent)
    puts @grid.print_grid2(player.shots_coordinates)
    puts 
    puts @grid.print_grid1(player.ships_coordinates, opponent.shots_coordinates)
  end

  def fire_shot(player, opponent)
    puts 'Enter shot coordinate:'
    shot = gets.chomp
    if opponent.ships_coordinates.values.flatten.include?(shot)
      puts 'HIT!'
      player.shots_coordinates[:hit] << shot
      opponent.ships_coordinates.each do |k, v|
        if v.difference(player.shots_coordinates[:hit]) == [] then puts "#{k.upcase} SANK!" end
      end
    else
      puts 'MISS!'
      player.shots_coordinates[:miss] << shot
    end
  end

  private

  def input_coordinates(ship, length, player)
    puts "#{ship.capitalize} (#{length}): "
    coordinates = gets.chomp
    save_ships_coordinates(ship, coordinates, player)
  end

  def split_coordinates(coordinates)
    coordinates = coordinates.split(' ')
    direction = coordinates.last
    start = coordinates.first.split('')
    start_horizontal = start.first
    start_vertical = start[1..-1].join.to_i
    return direction, start_horizontal, start_vertical
  end

  def save_ships_coordinates(ship, coordinates, player)
    length = SHIPS[ship]
    direction, start_horizontal, start_vertical = split_coordinates(coordinates)
    coordinates_array = []
    if direction.downcase == 'vertical'
      length.times do |n|
        raise 'Vertical Error' if (start_vertical + n) > 10
        coordinates_array << "#{start_horizontal}#{start_vertical + n}"
      end
    elsif direction.downcase == 'horizontal'
      length.times do |n|
        raise 'Horizontal Error' if (start_horizontal.ord + n) > 'J'.ord
        coordinates_array << "#{(start_horizontal.ord + n).chr}#{start_vertical}"
      end
    end
    player.ships_coordinates[ship] = coordinates_array
  end
end

if __FILE__ == $0
  player1 = Player.new('Player1')
  player2 = Player.new('Player2')
  g = Game.new(Grid.new)
  g.position_ships_instructions
  g.position_ships(player1, player2)
  g.play_screen(player1, player2)
  g.position_ships_instructions
  g.position_ships(player2, player1)
  g.play_screen(player2, player1)
  loop do
    sleep(2)
    puts "#{player1.name} your turn!"
    g.play_screen(player1, player2)
    g.fire_shot(player1, player2)
    g.play_screen(player1, player2)
    puts '-------------------------------------------'
    sleep(2)
    puts "#{player2.name} your turn!"
    g.play_screen(player2, player1)
    g.fire_shot(player2, player1)
    g.play_screen(player2, player1)
    puts '-------------------------------------------'
  end
end
