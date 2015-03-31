class UsersController < ApplicationController
	before_action :set_project, only: [:show,:destroy,:user_delete]

	def index		
		follows = Follow.where(user_id: current_user.id).pluck :followed_id
		follows << current_user.id
		@articles = Article.where(user_id: follows).uniq.sort.reverse
	end

	def show
		@user_articles = Article.where(user_id: @user.id)
	end

	def destroy
		@user.destroy
		redirect_to :back
	end

	def all_users
		@users = User.where(admin: 0)
		@follows = Follow.all
	end

	def user_delete
		followers = Follow.where(followed_id: @user.id)
		unless followers.empty?
			followers.each do |f|
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
