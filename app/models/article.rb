class Article < ActiveRecord::Base
	belongs_to :user
	has_many :comments, :dependent => :destroy
	has_many :favorites, :dependent => :destroy
	mount_uploader :image, ImageUploader

end


