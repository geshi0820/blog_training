class UsersController < ApplicationController

	def index		
		@user = current_user
		@users = User.all
		Follow.where(user_id: current_user.id).each do |f|
			@id = Article.where(user_id: f.followed_id).pluck(:id)
			@id += Article.where(user_id: @user.id).pluck(:id)
			@id = @id.reverse
			@articles = Article.all
		end
	end

	def show
		@user_id = User.find(params[:id]).id
		@user_name = User.find(params[:id]).username
		@user_article = Article.where("user_id=?",@user_id)
		@current_user_id = current_user.id
	end

	def destroy
		@user =User.find(params[:id])
		@user.destroy
		redirect_to :back
	end

	def all_users
		@user_id = current_user.id
		@users = User.where(admin: 0)
	end

	def user_delete
		@user = User.find(params[:id])
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






end
