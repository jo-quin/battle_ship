class Player
  attr_reader :name, :ships_coordinates, :shots_coordinates
  
  def initialize(name)
    @name = name
    @ships_coordinates = {}
    @shots_coordinates = { hit: [], miss: []}
  end
end
