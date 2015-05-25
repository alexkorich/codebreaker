require_relative("game.rb")
module Codebreaker
	class GameController
		def initialize()
			
		end

		def start()
			g=Game.new()
			puts "This is a codebreaker game. \n You have #{g.num_of_attempts} attempts"

			while true
				a=gets.chomp
				case a
					when /\d/
						if g.has_attempts
							if valid_guess(a)
								a=g.submit_guess(a.to_s)
								if a == "++++"
									player_wins

								end
								puts a
								puts "You have #{g.num_of_attempts} attempts"
							else
								puts "You entered non-valid code. \nCode should contain 4 digits from 1 to 6"
							end
						else 
							puts "You lose! \nPress n for new game, q for quit"

						end


					when 'h'
						puts g.get_hint

					when 'n'
						puts "You started a new game. \nYou have #{g.num_of_attempts} attempts."
						g=Game.new()
					when 'q'
						puts "bye!"
						break
				end
			end
		end

		def valid_guess(guess)
		 guess.to_s.match(/[1-6]+/)&&guess.to_s.length == 4
		end



	end
end
