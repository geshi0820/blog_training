class UsersController < ApplicationController

	def index		
		@user = User.find(current_user.id)
		@followers = Follow.where(user_id: current_user.id)
		@articles = Article.all	
		@users = User.all
		@follows = Follow.all
		@favorites = Favorite.all
	end

	def show
		@user_id = User.find(params[:id]).id
		@user_name = User.find(params[:id]).username
		@user_article = Article.where("user_id=?",@user_id)
		@current_user_id = current_user.id
	end

	def destroy
		@user =User.find(params[:id])
		@user.destroy
		redirect_to :back
	end

	def all_users
		@user_id = current_user.id
		@users = User.where(admin: 0)
	end

	def user_delete
		@user = User.find(params[:id])
		@follower = Follow.where(followed_id: @user.id).all
		if @follower != []
			@follower.each do |f|
				f.destroy
			end
		end
		@user.destroy
		redirect_to users_path
	end


end
