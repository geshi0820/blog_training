class UsersController < ApplicationController
	before_action :set_user, only: [:show,:destroy]
	before_filter :authenticate_user!
	before_action :check_admin, only: [:admin, :admin_articles, :delete_all_users, :delete_all_articles]

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

	def admin		
		@users = User.where(admin: false).includes(:articles,:follows,:reverse_follows)
	end

	def admin_articles
		unless current_user.admin?
			redirect_to users_path
		else
			@articles = Article.all.includes(:favorites)
		end
	end

	def delete_all_users
		unless current_user.admin?
			redirect_to users_path
		else
			@users = User.all
			@users.destroy_all
			redirect_to :back 
		end
	end

	def delete_all_articles
		unless current_user.admin?
			redirect_to users_path
		else
			Article.all.destroy_all
			redirect_to :back
		end
	end

	private
	def set_user
		@user = User.find(params[:id])
	end

	def check_admin
		unless current_user.admin?
			redirect_to users_path
		end
	end

end
