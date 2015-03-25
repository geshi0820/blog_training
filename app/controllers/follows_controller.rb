class FollowsController < ApplicationController
	def index
		id = params[:user_id]
		@user_name = User.find(id).username
		@follows = Follow.where(user_id: id)
	end

	def create
		@follow = Follow.new(:user_id => current_user.id, :followed_id => params[:user_id])
		@follow.save
		redirect_to :back
	end

	def destroy
		@follow = Follow.find(params[:id])
		@follow.destroy
		redirect_to :back
	end
	
end

