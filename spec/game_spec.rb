require 'spec_helper'


module Codebreaker
	describe Game do
		describe "#start" do
			before(:each) do
				@game = Game.new
			end

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
			it " has 6 attempts" do
				expect(@game.num_of_attempts).to eq(6)
			end

			it "changes secret code for each new game" do
				a=Game.new()
				b=Game.new()
				expect(a.instance_variable_get(:@secret_code)).not_to eq(b.instance_variable_get(:@secret_code))
			end
			xit "restricts direct access to secret code" do
				expect(Game.new.secret_code).to raise_error(NoMethodError)

			end			
		end

		describe "#submit_guess" do
			before(:each) do
				@game = Game.new
			end

			it "takes a guesses"  do
				expect(@game).to respond_to(:submit_guess).with(1).argument
			end

			it "shows first digit when hint used" do
			@game.get_hint
			expect(@game.submit_guess(1111)[0]).to match(/[1-6]+/)
			end

			it "decrements number of attempts after each submit" do
				expect(@game.num_of_attempts).to eq(6)
				@game.submit_guess(1111)
				expect(@game.num_of_attempts).to eq(5)
			end
		end
	end
end