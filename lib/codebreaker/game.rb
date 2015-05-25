module Codebreaker
	class Game
		attr_reader :num_of_attempts, :hint_used

		def initialize()
			@num_of_attempts=6
			@hint_used = false
			@secret_code = generate_code

		end
		def get_hint
			@hint_used=true
		end

		def submit_guess(guess)
			respond=[]
			g=guess.to_s.split(//)
			s=@secret_code.split(//)
			g.each_index do |i|
				if g[i]==s[i]
					respond.push("+")
					s[i]="x"
				elsif s.include?(g[i])
					respond.push("-") 
				end
			end

			if @hint_used
				respond[0]=s[0]
			end 
			@num_of_attempts-=1
			respond.join
		end


		private
		def generate_code
			a=[]
			4.times do
				a<<1+rand(6)
			end
			a.join
		end
	end
end