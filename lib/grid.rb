class Grid 
  def print_grid1(coordinates, sign = 0)
    coordinates.empty? ? coordinates_array = [] : coordinates_array = coordinates.values.flatten
    grid = "  |"
    ('A'..'J').each { |l| grid += " #{l} |" }
    grid += "\n"
    10.times do |n|
      (n == 9)? row = "#{ n + 1 }|" : row = "#{ n + 1 } |"
      ('A'..'J').each do |l|
        coordinates_array.include?("#{l}#{ n + 1 }") ? row += " #{sign} |" : row += '   |'
      end
      grid += row + "\n"
    end
    grid
  end

  def print_grid2(coordinates)
    grid = "  |"
    ('A'..'J').each { |l| grid += " #{l} |" }
    grid += "\n"
    10.times do |n|
      (n == 9)? row = "#{ n + 1 }|" : row = "#{ n + 1 } |"
      ('A'..'J').each do |l|
        if coordinates[:hit].include?("#{l}#{ n + 1 }")
          red_x = "\e[31mX\e[0m"
          row += " #{red_x} |"
        elsif coordinates[:miss].include?("#{l}#{ n + 1 }")
          row += " X |"
        else
          row += '   |'
        end
      end
      grid += row + "\n"
    end
    grid
  end
end
