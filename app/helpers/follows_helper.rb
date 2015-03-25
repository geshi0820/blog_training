module FollowsHelper
	def follow_or_not(followed_id,user_id)
		if Follow.where("user_id = ? and followed_id = ?", user_id, followed_id).pluck(:user_id,:followed_id).include?([user_id,followed_id])
			p 1
		else
			p "followしていません。"
		end
	end
end
