module ArticlesHelper

	def author_name(article_id)
		user_id = Article.find(article_id).user_id
		User.find(user_id).username
	end

	def article_favorite_count(article_id)
		p Favorite.where("article_id=?",article_id).count
	end

	def article_favorite(article_id)
		p Article.where(id: article_id).first
	end


end
