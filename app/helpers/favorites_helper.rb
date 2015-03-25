module FavoritesHelper
		def favorite_or_not(article_id)
			 if Favorite.where("user_id=? and article_id=?",current_user.id,article_id).pluck(:user_id,:article_id).include?([current_user.id,article_id])
			 	p 1
			 else
			 	p 2
			 end
				



	  # def favorite_or_not(author_id,user_id)
  	# if Favorite.where("article_id = ? and user_id = ?", author_id , user_id).pluck(:article_id,:user_id).include?([author_id,user_id])
  	# 	p 1
  	# end
  end
end
