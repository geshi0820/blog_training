class UsersController < ApplicationController
	before_action :set_user, only: [:show,:destroy]
	before_action :admin_check, only: [:admin,:admin_articles]

	def index
		if current_user.admin?
			redirect_to admin_users_path
		else
			follows = Follow.where(user_id: current_user.id).pluck :followed_id
			follows << current_user.id
			@articles = Article.where(user_id: follows).includes(:user,:favorites).sort.reverse
		end
	end
	
	def show
		@user_articles = Article.where(user_id: @user.id).includes(:favorites)
		@follows = Follow.all
	end

	def destroy
		@user.destroy
		redirect_to :back
	end

	def all_users
		@users = User.where(admin: false).includes(:articles,:follows,:reverse_follows)
	end

	def user_delete
		@user = User.find(params[:id])
		follows = @user.reverse_follows
		p follows
		unless follows.empty?
			follows.destroy_all
		end
		@user.destroy
		redirect_to users_path
	end

	def admin
		@users = User.where(admin: false).includes(:articles,:follows,:reverse_follows)
	end

	def admin_articles
		@articles = Article.all.includes(:favorites)
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
	def set_user
		@user = User.find(params[:id])
	end

	def admin_check
		unless current_user.admin?
			redirect_to users_path
		end
	end
end
