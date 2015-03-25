class UsersController < ApplicationController

	def index
	end

	def show
		@user_id = User.find(params[:id]).id
		@user_name = User.find(params[:id]).username
		@user_article = Article.where("user_id=?",@user_id)
	end
end
