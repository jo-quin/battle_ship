class Grid
  def print_grid(coordinates = [])
    coordinates.empty? ? coordinates_array = []
: coordinates_array = coordinates.values.flatten
    grid = "  |"
    ('A'..'J').each { |l| grid += " #{l} |" }
    grid += "\n"
    10.times do |n|
      (n == 9)? row = "#{ n + 1 }|" : row = "#{ n + 1 } |"
      ('A'..'J').each do |l|
        coordinates_array.include?("#{l}#{ n + 1 }") ? row += ' 0 |' : row += '   |'
      end
      grid += row + "\n"
    end
    grid
  end
end
