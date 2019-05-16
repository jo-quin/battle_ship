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
    string
  end

  def position_ships(player, opponent)
    player.client.puts position_ships_instructions
    SHIPS.each do |ship, length|
      player.client.puts @grid.print_grid1(player.ships_coordinates,opponent.shots_coordinates)
      begin
        input_coordinates(ship, length, player)
      rescue StandardError => e
        player.client.puts error_message
        retry
      end
    end
    return player.client.puts "\n All ships positioned and ready! \n"
  end

  def play_screen(player, opponent)
    return @grid.print_grid2(player.shots_coordinates), @grid.print_grid1(player.ships_coordinates, opponent.shots_coordinates) #need to return both
  end

  def fire_shot(player, opponent)
    player.client.puts 'Enter shot coordinate:'
    shot = player.client.gets.chomp
    if opponent.ships_coordinates.values.flatten.include?(shot)
      player.shots_coordinates[:hit] << shot
      opponent.ships_coordinates.each do |k, v|
        if v.difference(player.shots_coordinates[:hit]) == [] then return "#{k.upcase} SANK!" end
      end
      return 'HIT!'
    else
      player.shots_coordinates[:miss] << shot
      return 'MISS!'
    end
  end

  private

  def position_ships_instructions
    return "\n To position your ships on the grid enter starting coordinates (A to J and 1 to 10) and vertical or horizontal.
EXAMPLE: B5 vertical\n"
  end

  def error_message
    return "\n Wrong coordinates! Try again.\n"
  end

  def input_coordinates(ship, length, player)
    player.client.puts "#{ship.capitalize} (#{length}): "
    coordinates = player.client.gets.chomp
    save_ships_coordinates(ship, coordinates, player)
  end

  def split_coordinates(coordinates)
    coordinates = coordinates.split(' ')
    direction = coordinates.last
    start = coordinates.first.split('')
    start_horizontal = start.first
    start_vertical = start[1..-1].join.to_i
    # catch here the errors in A1, vertical and horizontal
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
    player.ships_coordinates.each do |ship, coordinates|
      raise 'Used Coordinates Error' if coordinates.any? { |coordinate| coordinates_array.include? coordinate }
    end
    player.ships_coordinates[ship] = coordinates_array
  end
end
