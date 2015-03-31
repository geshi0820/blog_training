class ArticlesController < ApplicationController
	
	before_action :facebook
	before_action :set_project, only:[:edit,:show,:update,:destroy,] 
require "RMagick"

	def index
		@articles = Article.all.reverse
		@favorites = Favorite.all
	end

	def show
		@articles = Article.all 
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
			redirect_to root_url
		else
			redirect_to :back
		end
	end

	def edit
	end

	def update
		if @article.update(article_params)
			redirect_to articles_path
		else
			render 'edit'
		end
	end

	def destroy
		@article.destroy
		redirect_to :back
	end

	def profile
		@articles = Article.where(user_id: current_user.id )	
	end

	private
	def article_params
		params[:article].permit(:title,:article,:user_id,:image, :remote_image_url)
	end

	def comment_params
		params[:comment].permit(:comment, :user_id)
	end

	def set_project
		@article = Article.find(params[:id])		
	end	
	
	def facebook
		token = "CAAWF8XmmjJEBAI2bTSdbm0UWBWcBgFB1DZCCGD6yM4ZAqYfjmyZB7JFyiQGSsFNZBmtw2LWWkz3qmbt7QmgZC8doxMyECRLRb6GpXGdhnXC7HIt9vFPZAB0bsGaKOqFco9HoKYFuSykHRbB6yHQWZC8LtRGOxssIxPywp5rwoGHKUPXLiTw6oYR3JzFzcAWO7fs5UsD4rhLa1OiR5Y3WDxd"
		facebook = Koala::Facebook::API.new(token)
		# @name = facebook.get_object('me')["name"]
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