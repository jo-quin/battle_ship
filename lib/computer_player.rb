class ComputerPlayer
  SHIPS = {
    carrier: { length: 5, vertical: 6, horizontal: 'F' },
    battleship: { length: 4, vertical: 7, horizontal: 'G' },
    cruiser: { length: 3, vertical: 8, horizontal: 'H' },
    submarine: { length: 3, vertical: 8, horizontal: 'H' },
    destroyer: { length: 2, vertical: 9, horizontal: 'I' }
  }

  attr_reader :name, :shots

  def initialize(name = 'Computer')
    @name = name
    @shots = []
    
    ('A'..'J').each do |l|
      10.times do |n|
        @shots << "#{l}#{n + 1}"
      end
    end
  end

  def input(line)
    begin
      if line.chop == 'Enter your name:'
        @name
      elsif line.chop == 'Enter shot coordinate:'
        shot = @shots.sample
        @shots.delete(shot)
        shot
      elsif SHIPS.include? line.chop.split(' ').first.downcase.to_sym and line.chop.split(' ')[-1] != 'SANK!'
        ship_valid_coordinates(line.chop.split(' ').first.downcase)
      end
    rescue
    end
  end

  def ship_valid_coordinates(ship, direction = ship_direction)
    ship_attributes = SHIPS[ship.to_sym]
    if direction == 'vertical'
      vertical_coordinate = rand(1..ship_attributes[:vertical])
      horizontal_coordinate = rand(65..74).chr
    elsif direction == 'horizontal'
      horizontal_coordinate = rand(65..ship_attributes[:horizontal].ord).chr
      vertical_coordinate = rand(1..10)
    end
    "#{horizontal_coordinate}#{vertical_coordinate} #{direction}"
  end

  private

  def ship_direction
    ['vertical', 'horizontal'].sample
  end
end
