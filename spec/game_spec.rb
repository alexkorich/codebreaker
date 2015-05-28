require 'spec_helper'


module Codebreaker
	describe Game do
		before(:each) do
				@game = Game.new
			end

		describe "#initialize" do
			it "generates secret code" do
				expect(@game.instance_variable_get(:@secret_code)).not_to be_empty
			end
			it "saves 4 numbers secret code" do
 		        expect(@game.instance_variable_get(:@secret_code).length).to eq(4)
		      end
			it "saved symbols are numbers" do
				expect(@game.instance_variable_get(:@secret_code).to_i).not_to eq(0)
			end
			it "saves secret code with numbers from 1 to 6" do
				expect(@game.instance_variable_get(:@secret_code)).to match(/[1-6]+/)
			 end
			it "creates 6 attempts" do
				expect(@game.attempts).to eq(6)
			end

			it "hint is empty unless called get_hint" do
				expect(@game.instance_variable_get(:@hint)).to eq('')
			end
			xit "restricts direct access to secret code" do
				expect(Game.new.secret_code).to raise_error(NoMethodError)

			end			
		end

		describe "#get_hint" do
			it "shows any one digit when hint used" do
				expect(@game.get_hint).to match(/\d{1}/)
			end
			it "shows same hint on next call" do
				a=@game.get_hint
				b=@game.get_hint
				expect(a).to eq(b)
			end
		end
		describe "#zzz" do
				it "return secret code"  do
					expect(@game.zzz).to eq(@game.instance_variable_get(:@secret_code))
				end
		end

		describe "#submit_guess" do 
			it "takes a guesses"  do
				expect(@game).to respond_to(:submit_guess).with(1).argument
			end
			it "decrements number of attempts after each submit" do
				expect(@game.attempts).to eq(6)
				@game.submit_guess(1111)
				expect(@game.attempts).to eq(5)
			end
			it "returns 'You lose!' if no attempts left" do
				@game.instance_variable_set(:@attempts, 0)
				expect(@game.submit_guess(1111)).to eq('You lose!')
			end

			context "returns message if guess is not valid" do
				it "rejects 11111" do
					expect(@game.submit_guess(11111)).to eq("Please, enter 4-digits code with 1-6 numbers")
				end
				it "rejects 111" do
					expect(@game.submit_guess(111)).to eq("Please, enter 4-digits code with 1-6 numbers")
				end
				it "rejects 1238" do
					expect(@game.submit_guess(1238)).to eq("Please, enter 4-digits code with 1-6 numbers")
				end
				it "rejects 'aaaa'" do
					expect(@game.submit_guess('aaaa')).to eq("Please, enter 4-digits code with 1-6 numbers")
				end
				it "rejects 'w111'" do
					expect(@game.submit_guess('w111')).to eq("Please, enter 4-digits code with 1-6 numbers")
				end
				it "rejects 1" do
					expect(@game.submit_guess(1)).to eq("Please, enter 4-digits code with 1-6 numbers")
				end
			end

			context "taking guesses" do
			before(:each) do
				@game = Game.new
				@game.instance_variable_set(:@secret_code, "1234")
			end
			a=[{code:1234, respond:"++++"}, {code:1255, respond:"++"}, {code:4321, respond:"----"}, {code:5554, respond:"+"}, 
			{code:4666, respond:"-"}, {code:6666, respond:""}, {code:1243, respond:"++--"}, {code:2134, respond:"++--"}, {code:1111, respond:"+"}]

			a.each do |x|
				it "returns responce " do
				expect(@game.submit_guess(x[:code])).to eq(x[:respond])
				end
			end


			end
		end

		describe ".save & .load" do
		xit "returns 'No highscore file found!' if no file" do
			expect(Game.load_score).to eq("No highscore file found!")
			end
		end
	end
end