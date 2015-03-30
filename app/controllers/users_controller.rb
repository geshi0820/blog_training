class UsersController < ApplicationController
	before_action :set_project, only: [:show,:destroy,:user_delete]
	def index		
		@users = User.all	
		@articles = Article.all
		@id = Article.where(user_id: current_user.id).pluck(:id)
		Follow.where(user_id: current_user.id).each do |f|
			if f.followed_id != current_user.id
				@id += Article.where(user_id: f.followed_id).pluck(:id)
			end
		end
		@id = @id.sort.reverse
	end

	def show
		@user_article = Article.where("user_id=?",@user.id)
	end

	def destroy
		@user.destroy
		redirect_to :back
	end

	def all_users
		@users = User.where(admin: 0)
	end

	def user_delete
		@follower = Follow.where(followed_id: @user.id).all
		if @follower != []
			@follower.each do |f|
				f.destroy
			end
		end
		@user.destroy
		redirect_to users_path
	end

	def admin
		@users = User.all
		@articles = Article.all
	end

	def delete_all_users
		@users = User.all
		@users.destroy_all
		redirect_to :back 
	end

	def delete_all_articles
		Article.all.destroy_all
		redirect_to :back
	end

	private
	def set_project
		@user = User.find(params[:id])
	end
end
