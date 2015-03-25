class CommentsController < ApplicationController

	before_action :set_project
	def create
		
		@comment = @article.comments.create(comment_params)
		redirect_to article_path(@article.id)
	end	

	def destroy
		@comment = Comment.find(params[:id])
		@comment.destroy
		redirect_to article_path(@article.id)
	end
	
	def edit
		@comment = Comment.find(params[:id])
	end
	
	def update
		@comment = Comment.find(params[:id])
		if @comment.update(comment_params)
			redirect_to article_path(@article)
		end
	end
	
	private
	def comment_params
		params[:comment].permit(:comment, :user_id)
	end

	def set_project
		@article = Article.find(params[:article_id])
	end
	
end
