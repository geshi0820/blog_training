class CommentsController < ApplicationController

	before_action :set_project1, except:[:create]
	before_action :set_project2
	def create
		@comment = @article.comments.create(comment_params)
		redirect_to article_path(@article.id)
	end	

	def destroy
		@comment.destroy
		redirect_to article_path(@article.id)
	end
	
	def edit
	end
	
	def update
		if @comment.update(comment_params)
			redirect_to article_path(@article)
		end
	end
	
	private
	def set_project1
		@comment = Comment.find(params[:id])
	end

	def comment_params
		params[:comment].permit(:comment, :user_id)
	end

	def set_project2
		@article = Article.find(params[:article_id])
	end
	
end
