module ApplicationHelper
	def tokyotime(time)
		time.strftime("%Y年%m月%d日 %H:%M")
	end

	def user_image(user_id)
			user = User.find(user_id)
			if user.uid
				uid = user.uid.to_s
				@picture = "https://graph.facebook.com/"+uid+"/picture?type=square"
				"https://graph.facebook.com/598921006908818/picture"
			else
				user.image_url(:thumb).to_s
			end
	end

end
