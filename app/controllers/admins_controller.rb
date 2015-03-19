class AdminsController < ApplicationController
	def index
		@articles = Article.all
		@users = User.all
		@follows = Follow.all
		@favorites = Favorite.all
	end

	def delete_all_users
		@users = User.all
		@users.destroy_all
		redirect_to :back 
	end

	def delete_all_articles
		Article.all.destroy_all
		redirect_to :back
	end

	def delete_user
		@user = User.find(params[:id])
		@user.destroy
		redirect_to :back
	end

	private
	def user_params
		params[:user].permit(:id,:email,:password,:image,:admin,)	
	end
end
