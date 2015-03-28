class ArticlesController < ApplicationController
	before_action :set_project
	before_action :facebook
require "RMagick"

	def index
		@favorites = Favorite.all
		@follows = Follow.all
		@user_name = User.find(current_user.id).username
	end

	def show
		@article = Article.find(params[:id])
	end

	def new
		@article = Article.new
	end

	def create
		tmp_article_params = article_params
		image_data = base64_conversion(tmp_article_params[:remote_image_url])
		tmp_article_params[:image] = image_data
		tmp_article_params[:remote_image_url] = nil
		article = Article.new(tmp_article_params)
		if article.save
			redirect_to articles_path
		else
			redirect_to :back
		end
	end

	def edit
		@article = Article.find(params[:id])
	end

	def update
		@article = Article.find(params[:id])
		if @article.update(article_params)
			redirect_to articles_path
		else
			render 'edit'
		end
	end

	def destroy
		@article =Article.find(params[:id])
		@article.destroy
		redirect_to :back
	end

	def profile
		@articles = Article.where("user_id = ?", current_user.id )	
	end

	def favorite_index
		@article_id = Favorite.where("user_id=?",current_user.id).pluck(:article_id)
		@article = Article.all
	end

	def follow_index
		@follow_id = Follow.where("user_id=?",current_user.id)
		@follows = Follow.all
	end


	private
	def article_params
		params[:article].permit(:title,:article,:user_id,:image, :remote_image_url)
	end

	def comment_params
		params[:comment].permit(:comment, :user_id)
	end

	def facebook
		token = "CAAWF8XmmjJEBAI2bTSdbm0UWBWcBgFB1DZCCGD6yM4ZAqYfjmyZB7JFyiQGSsFNZBmtw2LWWkz3qmbt7QmgZC8doxMyECRLRb6GpXGdhnXC7HIt9vFPZAB0bsGaKOqFco9HoKYFuSykHRbB6yHQWZC8LtRGOxssIxPywp5rwoGHKUPXLiTw6oYR3JzFzcAWO7fs5UsD4rhLa1OiR5Y3WDxd"
		facebook = Koala::Facebook::API.new(token)
		# @name = facebook.get_object('me')["name"]
	end

	def set_project
		@articles = Article.all
		@users = User.all
		@user_id = current_user.id
	end

	def base64_conversion(uri_str, filename = 'base64')
		image_data = split_base64(uri_str)
		image_data_string = image_data[:data]
		image_data_binary = Base64.decode64(image_data_string)
		temp_img_file = Tempfile.new(filename)
		temp_img_file.binmode
		temp_img_file << image_data_binary
		temp_img_file.rewind
		img_params = {:filename => "#{filename}.#{image_data[:extension]}", :type => image_data[:type], :tempfile => temp_img_file}
		ActionDispatch::Http::UploadedFile.new(img_params)
	end

	def split_base64(uri_str)
		if uri_str.match(%r{data:(.*?);(.*?),(.*)$})
			uri = Hash.new
			uri[:type] = $1
			uri[:encoder] = $2
			uri[:data] = $3
			uri[:extension] = $1.split('/')[1]
			return uri
		else
			return nil
		end
	end
end