require 'faker'

FactoryGirl.define do
	factory :user do	
		username { Faker::Name.name}
		email { Faker::Internet.email}
		password "hirohiro"
		admin false
	end
end
