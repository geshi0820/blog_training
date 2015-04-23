require 'spec_helper'

describe Article do 
	
	describe "with a validation" do
		it "is valid with a title, article and image" do
			expect(build(:article)).to be_valid
		end

		it "is invalid without a title" do
			article = build(:article, title: nil)
			expect(article).to have(1).errors_on(:title)
		end
	end
end

