module ArticlesHelper

  def author_name(article_id)
  	 user_id = Article.find(article_id).user_id
     User.find(user_id).username
  end

  def favorite_id(article_id)
  	Favorite.where("article_id=?",article_id).pluck(:id).at(0)
  end
end
