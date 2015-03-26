module UsersHelper

	def user_follow_count(user_id)
		p Follow.where("user_id=?",user_id).count
	end

	def user_follower_count(user_id)
		p Follow.where("followed_id=?",user_id).count
	end

	def user_favorite_count(user_id)
		p Favorite.where(user_id: user_id).count
	end

	def user_article_count(user_id)
		p Article.where(user_id: user_id).count
	end

	def user_image(user_id)
		user = User.find(user_id)
	 	if user.uid
	 		uid = user.uid.to_s
			@picture = "https://graph.facebook.com/"+uid+"/picture?type=square"
	 		p "https://graph.facebook.com/598921006908818/picture"
	 	else
	 		 user.image_url(:thumb).to_s
	 	end
	end



end
