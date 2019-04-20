class Game
  SHIPS = {
    carrier: [1, 5],
    battleship: [2, 4],
    cruiser: [3, 3],
    submarine: [4, 3],
    destroyer: [5, 2]
  }
  def ships
    string = ''
    SHIPS.each do |ship, details|
      string += "#{ship.capitalize} Qty: #{details.first} Length: #{details.last}\n"
    end
    puts string
  end
end
