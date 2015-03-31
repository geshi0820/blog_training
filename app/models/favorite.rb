class Favorite < ActiveRecord::Base
	belongs_to :article 
	belongs_to :user

	def article_favorite_count(article_id)
		Favorite.where(article_id: article_id).count
	end
end


