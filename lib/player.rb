class Player
  attr_reader :name, :client, :ships_coordinates, :shots_coordinates, :ships_sank
  
  def initialize(name, client)
    @name = name
    @client = client
    @ships_coordinates = {}
    @shots_coordinates = { hit: [], miss: []}
    @ships_sank = []
  end
end
