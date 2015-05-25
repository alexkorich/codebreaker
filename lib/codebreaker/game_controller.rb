require_relative("game.rb")
module Codebreaker
	class GameController
		def initialize()
			
		end

		def start()
			g=Game.new()
			puts "This is a codebreaker game. \n You have 5 attempts"

			while true
				a=gets.chomp
				case a
					when Fixnum

					when 'n'
						g=Game.new()
					when 'q'
						break
				end
			end
		end
	end
end
