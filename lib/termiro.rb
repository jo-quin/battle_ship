
module Termiro

	COLORS = { r: "\u001b[41m \u001b[0m", 
	y: "\u001b[43m \u001b[0m",
	b: "\u001b[44m \u001b[0m", 
	g: "\u001b[42m \u001b[0m", 
	w: "\u001b[47m \u001b[0m", 
	x: "\u001b[40m \u001b[0m"}



	def draw(file)
		graphic = ""
		lines= File.readlines("graphics/#{file}.txt")
		lines.each do |line|
		  line.each_char do |color|
		  	# sleep 0.01
		  	if color == '-'
		  		graphic += ' '
		  	else
		    	graphic += COLORS[color.to_sym].to_s
		    end
		  end
		  graphic += "\n"
		end
		return graphic
	end
end
