class ArticlesController < ApplicationController

	before_action :facebook,:set_project


	def index
		@favorites = Favorite.all
		@follows = Follow.all
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
		@article = Article.new(tmp_article_params)
		if @article.save
			redirect_to articles_path
		end
	end

	def edit
		@article = Article.find(params[:id])
	end

	def update
		@article = Article.find(params[:id])
		if @article.update(article_params)
			redirect_to :back
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
	# 	uid = current_user.uid.to_s
	# 	@picture = "https://graph.facebook.com/"+uid+"/picture?type=square"
	# 	token = "CAAWF8XmmjJEBACLtCplvw2pq9lCOAkjLV7xvKk0y3ZBG8QBxbymUJOx3B82NpW2VmKZCP1mWM6MG1cUC0ajn1fY62VX1A8LUh01K2nS3n9DdzjjUuFySrItIVxuN22pLF1BoX9QyL1At0WvHyOZA2CeMoCIXa12mFHtOLa22ECam336J0ZAVZAfzOYMZAUEcNpeJHrimEIUore1nzdS22yhFFuWmnwY9MZD"
	# 	facebook = Koala::Facebook::API.new(token)
	# 	@name = facebook.get_object('me')
	end

	def set_project
		@articles = Article.all
		@users = User.all
		@userid = current_user.id
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

