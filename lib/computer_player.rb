class ComputerPlayer
  SHIPS = {
    carrier: { length: 5, vertical: 6, horizontal: 'F' },
    battleship: { length: 4, vertical: 7, horizontal: 'G' },
    cruiser: { length: 3, vertical: 8, horizontal: 'H' },
    submarine: { length: 3, vertical: 8, horizontal: 'H' },
    destroyer: { length: 2, vertical: 9, horizontal: 'I' }
  }

  attr_accessor :name, :shots, :last_hit, :shot

  def initialize(name = 'Computer')
    @name = name
    @shots = []
    @shot = ''
    @last_hit = { coordinate: '', option: 1 }
    
    ('A'..'J').each do |l|
      10.times do |n|
        @shots << "#{l}#{n + 1}"
      end
    end
  end

  def input(line)
    begin
      if line.chop == 'hit'
        new_last_hit
        return nil
      elsif line.chop.split(' ')[-1] == 'SANK!'
        reset_last_hit
        return nil
      elsif line.chop == 'Enter your name:'
        return @name
      elsif line.chop == 'Enter shot coordinate:'
        declare_shot
      elsif SHIPS.include? line.chop.split(' ').first.downcase.to_sym and line.chop.split(' ')[-1] != 'SANK!'
        ship_valid_coordinates(line.chop.split(' ').first.downcase)
      end
    rescue
      return nil
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

  def choose_shot_option
    send("shot_option_#{@last_hit[:option]}", @last_hit[:coordinate])
  end

  def update_shot_option
    @last_hit[:option] += 1
  end

  def retrieve_random_shot
    @shots.delete(@shots.sample)
  end

  def new_last_hit
    @last_hit[:coordinate], @last_hit[:option] = @shot, 1
  end

  def reset_last_hit
    @last_hit[:coordintate], @last_hit[:option] = '', 1
  end

  def declare_shot
    if @last_hit[:coordinate] != ''
      loop do 
        if @last_hit[:option] > 4
          reset_last_hit
          return @shot = retrieve_random_shot
        end
        @shot = choose_shot_option
        update_shot_option
        
        if @shots.include? @shot
          @shots.delete(@shot)
          return @shot
        end
      end
    else
      return @shot = retrieve_random_shot
    end
  end

  def shot_option_1(shot)
    (shot[0].ord + 1).chr + shot[1]
  end

  def shot_option_2(shot)
    (shot[0].ord - 1).chr + shot[1]
  end

  def shot_option_3(shot)
    shot[0] + (shot[1].to_i + 1).to_s
  end

  def shot_option_4(shot)
    shot[0] + (shot[1].to_i - 1).to_s
  end

  private

  def ship_direction
    ['vertical', 'horizontal'].sample
  end
end
