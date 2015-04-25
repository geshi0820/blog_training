class UsersController < ApplicationController
	before_action :set_user, only: [:show,:destroy, :following, :followers, :favorite]
	before_filter :authenticate_user!
	before_action :check_admin, only: [:delete_all_users, :delete_all_articles]

	def index
		follows = Follow.where(user_id: current_user.id).pluck(:followed_id) << current_user.id
		@articles = Article.where(user_id: follows).includes(:user,:favorites).sort.reverse
	end
	
	def show
		@user_articles = Article.where(user_id: @user.id).includes(:favorites)
		@follows = Follow.all
	end

	def following
		user_follows = Follow.where(user_id: @user.id).pluck(:followed_id)
		@users = User.includes(:follows,:reverse_follows,:articles).find(user_follows)
	end

	def follower
		followers = Follow.where(followed_id: @user.id).pluck(:user_id)
		@users = User.includes(:follows,:reverse_follows,:articles).find(followers)
	end

	def favorite
		favorites = Favorite.where(user_id: @user.id).pluck(:article_id)
		@articles = Article.find(favorites)
	end

	def destroy
		@user.destroy
		redirect_to :back
	end

	# def destroy_all_users
	# 	@users = User.all
	# 	@users.destroy_all
	# 	redirect_to :back 
	# end

	# def destroy_all_articles
	# 	Article.all.destroy_all
	# 	redirect_to :back
	# end

	private
	def set_user
		@user = User.find(params[:id])
	end

	def check_admin
		unless current_user.admin?
			redirect_to users_path
		end
	end
end
