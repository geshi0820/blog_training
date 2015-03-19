class FollowsController < ApplicationController
	def create
		@userid = current_user.id
		@article = Article.find(params[:article_id]).user_id
		@follow = Follow.new(:user_id => @userid, :followed_id => @article)
	
		@follow.save
		redirect_to articles_path
	end
	def destroy
		@follow = Follow.find(params[:id])
		@follow.destroy
		redirect_to articles_path	
	end
	
end

