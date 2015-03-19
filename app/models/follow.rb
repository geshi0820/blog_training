class Follow < ActiveRecord::Base
	  belongs_to :user

  validates :user_id,
  uniqueness: {
  	  	scope: [:user_id]}
end
