require 'faker'

FactoryGirl.define do
	factory :article do
		association :user 
		title {Faker::Name.title}
		article {Faker::Lorem.sentence}
	end
end