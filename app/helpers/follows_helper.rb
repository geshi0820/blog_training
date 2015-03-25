module FollowsHelper
	def follow_or_not(followed_id,user_id)
		if Follow.where("user_id = ? and followed_id = ?", user_id, followed_id).pluck(:user_id,:followed_id).include?([user_id,followed_id])
			p 1
		else
			p "followしていません。"
		end
	end

	def follow_id(followed_id)
		Follow.where(user_id: current_user.id, followed_id: followed_id).first.id
	end

	def follow_name(followed_id)
		p User.find(followed_id).username
	end

end
