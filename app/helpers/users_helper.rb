module UsersHelper

	def follow_count(user_id)
		p Follow.where("user_id=?",user_id).count
	end

	def follower_count(user_id)
		p Follow.where("followed_id=?",user_id).count
	end
	
	def favorite_count(article_id)
		p Favorite.where("article_id=?",article_id).count
	end
	
	def author_or_not(article_id,author_id)
		if Article.where("id=?",article_id).pluck("user_id").at(0)== author_id
			p "true"
		else 
			p "false"
		end
	end
end
