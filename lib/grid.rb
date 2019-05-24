class Grid 
  def print_grid1(ships_coordinates, opponents_shots)
    ships_coordinates.empty? ? coordinates_array = [] : coordinates_array = ships_coordinates.values.flatten
    grid = "\n   |"
    ('A'..'J').each { |l| grid += " #{l} |" }
    grid += "\n"
    10.times do |n|
      (n == 9)? row = " #{ n + 1 }|" : row = " #{ n + 1 } |"
      ('A'..'J').each do |l|
        if opponents_shots[:hit].include?("#{l}#{ n + 1 }")
          red_x = "\e[91mX\e[0m"
          row += " #{red_x} |"
        elsif opponents_shots[:miss].include?("#{l}#{ n + 1 }")
          blue_x = "\e[36mX\e[0m"
          row += " #{blue_x} |"
        else
          coordinates_array.include?("#{l}#{ n + 1 }") ? row += " 0 |" : row += '   |'
        end
      end
      grid += row + "\n"
    end
    grid + "\n"
  end

  def print_grid2(coordinates)
    grid = "\n   |"
    ('A'..'J').each { |l| grid += " #{l} |" }
    grid += "\n"
    10.times do |n|
      (n == 9)? row = " #{ n + 1 }|" : row = " #{ n + 1 } |"
      ('A'..'J').each do |l|
        if coordinates[:hit].include?("#{l}#{ n + 1 }")
          red_x = "\e[91mX\e[0m"
          row += " #{red_x} |"
        elsif coordinates[:miss].include?("#{l}#{ n + 1 }")
          blue_x = "\e[36mX\e[0m"
          row += " #{blue_x} |"
        else
          row += '   |'
        end
      end
      grid += row + "\n"
    end
    grid + "\n"
  end
end
