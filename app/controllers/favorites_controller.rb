class FavoritesController < ApplicationController

	def index
		user_id = params[:user_id]
		@user_name = User.find(user_id).username
		@article_id = Favorite.where(user_id: user_id)
		# @favorite_articles = Article.find(article_id)
	end

	def create
		@favorite = Favorite.new(:user_id => current_user.id, :article_id => params[:article_id])
		@favorite.save
		redirect_to articles_path
	end
	def destroy
		@favorite = Favorite.find(params[:id])
		@favorite.destroy
		redirect_to articles_path
	end

end
