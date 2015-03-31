class FollowsController < ApplicationController
	def index
		@user = User.find(params[:user_id])
		@follows = Follow.where(user_id: @user.id)
	end

	def create
		@follow = Follow.new(user_id: current_user.id, followed_id: params[:user_id])
		@follow.save
		redirect_to :back
	end

	def follower
		@user = User.find(params[:user_id])
		@follower = Follow.where(followed_id: @user.id)	
	end

	def destroy
		@follow = Follow.find(params[:id])
		@follow.destroy
		redirect_to :back
	end
end

