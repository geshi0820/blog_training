module ControllerMacros
	def login_admin(admin)
		@request.env["devise.mapping"]= Devise.mapping[:admin]
		sign_in admin
	end

	def login_user(user)		
		@request.env["devise.mapping"] = Devise.mapping[:user]
		user.confirm!
		sign_in user
	end
end
