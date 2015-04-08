class FollowsController < ApplicationController
	def index
		@user = User.find(params[:user_id])
		user_follows = Follow.where(user_id: @user.id).pluck(:followed_id)
		@users = User.includes(:follows,:reverse_follows,:articles).find(user_follows)
	end

	def create
		@follow = Follow.new(user_id: current_user.id, followed_id: params[:user_id])
		@follow.save
		redirect_to :back
	end

	def follower
		@user = User.find(params[:user_id])
		followers = Follow.where(followed_id: @user.id).pluck(:user_id)
		@users = User.includes(:follows,:reverse_follows,:articles).find(followers)
	end

	def destroy
		@follow = Follow.find(params[:id])
		@follow.destroy
		redirect_to :back
	end
end

