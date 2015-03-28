module FavoritesHelper
	
	# def favorite_or_not(article_id)
	# 	if Favorite.where("user_id=? and article_id=?",current_user.id,article_id).pluck(:user_id,:article_id).include?([current_user.id,article_id])
	# 		p 1
	# 	end
	# end

	# def favorite_id(article_id)
	# 	Favorite.where(user_id: current_user.id, article_id: article_id).first.id
	# end


end
