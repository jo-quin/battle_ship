class Grid
  def print_grid(coordinates)
    coordinates_array = []
    coordinates.each do |k, v|
      v.each { |coordinate| coordinates_array<<coordinate }
    end
    grid = "  |"
    ('A'..'J').each { |l| grid += " #{l} |" }
    grid += "\n"

    10.times do |n|
      (n == 9)? row = "#{ n + 1 }|" : row = "#{ n + 1 } |"
      
      ('A'..'J').each do |l|
        if coordinates_array.include? "#{l}#{ n + 1 }"
          row += ' 0 |'
        else
          row += '   |'
        end
      end
      grid += row + "\n"
    end
    grid
  end
end
