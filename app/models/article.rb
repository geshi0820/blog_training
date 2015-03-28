class Article < ActiveRecord::Base
  belongs_to :user
  has_many :comments, :dependent => :destroy
  has_many :favorites, :dependent => :destroy
  mount_uploader :image, ImageUploader


def author_name(article_id)
		user_id = Article.find(article_id).user_id
		User.find(user_id).username
	end

	def author_id(article_id)
		user_id = Article.find(article_id).user_id
	end

	def article_favorite_count(article_id)
		p Favorite.where("article_id=?",article_id).count
	end

	def article_favorite(article_id)
		Article.where(id: article_id).first
	end

	def author_or_not(article_id,author_id)
		if Article.where("id=?",article_id).pluck("user_id").at(0)== author_id
			p 1
		else 
			p ""
		end
	end

	def favorite_or_not(article_id,user_id)
    if Favorite.where("user_id=? and article_id=?",user_id,article_id).pluck(:user_id,:article_id).include?([user_id,article_id])
        p 1
    end
end

def favorite_id(article_id,user_id)
    Favorite.where(user_id: user_id, article_id: article_id).first.id
end

end
