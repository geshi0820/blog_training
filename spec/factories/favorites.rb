require 'faker'

FactoryGirl.define do
	factory :favorite do
		association	:user
		association :article
	end
end