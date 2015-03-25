module UsersHelper

	def user_follow_count(user_id)
		p Follow.where("followed_id=?",user_id).count
	end

	def user_follower_count(user_id)
		p Follow.where("user_id=?",user_id).count
	end

	def user_favorite_count(user_id)
		p Favorite.where(user_id: user_id).count
	end
	
	def author_or_not(article_id,author_id)
		if Article.where("id=?",article_id).pluck("user_id").at(0)== author_id
			p "true"
		else 
			p "false"
		end
	end
end
