class FavoritesController < ApplicationController

	def index
		@user = User.find(params[:user_id])
		@favorite_users = Favorite.where(user_id: @user.id)
		@articles = Article.all
		@favorites = Favorite.all
	end

	def create
		@favorite = Favorite.new(user_id: current_user.id, article_id: params[:article_id])
		@favorite.save
		redirect_to :back
	end

	def destroy
		@favorite = Favorite.find(params[:id])
		@favorite.destroy
		redirect_to :back
	end
end


