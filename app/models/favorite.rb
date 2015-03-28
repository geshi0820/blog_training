class Favorite < ActiveRecord::Base
	belongs_to :article
	belongs_to :user
	def article_favorite(article_id)
		Article.where(id: article_id).first
	end	
	def author_id(article_id)
		user_id = Article.find(article_id).user_id
	end

	
	def article_favorite_count(article_id)
		p Favorite.where("article_id=?",article_id).count
	end

	def favorite_or_not(article_id,user_id)
		if Favorite.where("user_id=? and article_id=?",user_id,article_id).pluck(:user_id,:article_id).include?([user_id,article_id])
			p 1
		end
	end

	    def favorite_id(article_id,user_id)
        Favorite.where(user_id: user_id, article_id: article_id).first.id
    end
end
