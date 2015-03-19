class Favorite < ActiveRecord::Base
  belongs_to :article
  belongs_to :user

  validates :user_id,
  uniqueness: {
  	scope: [:article_id]}
end
