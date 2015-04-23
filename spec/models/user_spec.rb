require 'spec_helper'

describe User do
	describe "with a validation" do
		it "is valid with a username, email and password" do
			expect(build(:user)).to be_valid
		end
		
		it "is invalid without a username" do
			expect(build(:user, username: nil)).to have(1).errors_on(:username)
		end

		it "is invalid without an email" do
			expect(build(:user, email: nil)).to have(1).errors_on(:email)
		end

		it "is invalid without a password" do
			expect(build(:user, password: nil)).to have(1).errors_on(:password)
		end

		describe "with a unique-key" do
			it "is invalid without a duplicate email address" do
				create(:user, email: 'aaa@mail.com')
				expect(build(:user, email: 'aaa@mail.com')).to have(1).errors_on(:email)
			end
		end
	end
end


