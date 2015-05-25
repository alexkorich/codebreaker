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
			@secret_code[0]+"xxx"
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
			@num_of_attempts-=1
			respond.join
		end

		def has_attempts
			@num_of_attempts>0
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