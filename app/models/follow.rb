class Follow < ActiveRecord::Base
	belongs_to :user

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

