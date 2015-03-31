class CommentsController < ApplicationController

	def create
		@comment = Comment.new(comment_params)
		@article = Article.find(params[:article_id])
		@comment = @article.comments.create(comment_params)
		redirect_to article_path(@article)
	end	

	def destroy
		@article = Article.find(params[:article_id])
		@comment = Comment.find(params[:id]).destroy
		redirect_to article_path(@article)
	end
	
	private
	def comment_params
		params[:comment].permit(:comment, :user_id)
	end
end
