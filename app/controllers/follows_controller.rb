class FollowsController < ApplicationController
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

