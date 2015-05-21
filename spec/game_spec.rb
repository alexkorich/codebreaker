require 'spec_helper'


module Codebreaker
	describe Game do
		describe "#start" do
			before(:each) do
				@game = Game.new
				@game.start
			end
			it "generates secret code" do
				expect(@game.instance_variable_get(:@secret_code)).not_to be_empty
			end
			it "saves 4 numbers secret code" do
    
        expect(@game.instance_variable_get(:@secret_code)).to have(4).items
      end
			it "saved symbols are numbers" do
				expect(@game.instance_variable_get(:@secret_code).to_i).not_to eq(0)
			end
			it "saves secret code with numbers from 1 to 6" do
				expect(@game.instance_variable_get(:@secret_code)).to match(/[1-6]+/)
			end
		end
		describe "submitting guesses" do
			# game=Game.new
			# game.start
			# expect
		end
	end
end