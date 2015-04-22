require 'spec_helper'

describe Article do 
	
	describe "with a validation" do
		it "is valid with a title, article and image" do
			expect(build(:article)).to be_valid
		end
	end
end

