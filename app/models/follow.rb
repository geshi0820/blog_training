class Follow < ActiveRecord::Base
	belongs_to :user

	def user_follow_count
		Follow.where(user_id: self.user_id).count
	end

	def user_follower_count
		Follow.where(followed_id: self.user_id).count
	end

	def follow_id(user_id,followed_id)
		Follow.where(user_id:user_id,followed_id:followed_id).first.id
	end

	def follow_name
		User.find(self).username
	end

	def user_article_count
		Article.where(user_id: self.user_id).count
	end

	def user_image
		user = User.find(self)
		if user.image.blank?
			if user.uid
				uid = user.uid.to_s
				"https://graph.facebook.com/"+uid+"/picture?type=square"
			else
				"http://www.oomoto.or.jp/japanese/_src/sc6732/90l95A883A83C83R8393.jpg"
			end
		else
			user.image_url(:thumb).to_s
		end
	end
end

