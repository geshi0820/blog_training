require 'spec_helper'

describe Favorite do
	describe "with a validation" do

		it "is valid with a user_id and article_id" do
			expect(build(:favorite)).to be_valid
		end

		it "is invalid without a user_id" do
			
		end

		it "is invalid without an article_id" do
			
		end
	end
	
	describe "with a unique key" do

	end

	describe "with a foreign_key" do

	end
end

