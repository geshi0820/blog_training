require 'spec_helper'

describe Article do 
	
	describe "with a validation" do
		it "is valid with a title, article and image" do
			expect(build(:article)).to be_valid
		end
	end
	
	describe "with a not-null" do
		it "is invalid without a user_id" do
			expect(build(:article, user_id: nil)).to have(1).errors_on(:user_id)
		end
	end

	# describe "with a unique-key" do
	# end
	
	describe "with a foreign-key" do
		it "is invalid because of invald foreign_key" do
			expect(build(:article, user_id: 99999)).to have(0).errors_on(:user_id)
		end
	end
end

