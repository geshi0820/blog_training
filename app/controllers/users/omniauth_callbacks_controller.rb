class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController


  
  def facebook
    callback_from :facebook
  end

  private

  def callback_from(provider)
    provider = provider.to_s
    @user = User.find_for_oauth(request.env['omniauth.auth'])
    if @user.persisted?
      flash[:notice] = I18n.t('devise.omniauth_callbacks.success', kind: provider.capitalize)
      sign_in_and_redirect @user, event: :authentication
    else
      session["devise.#{provider}_data"] = request.env['omniauth.auth']
      token = "CAAWF8XmmjJEBACLtCplvw2pq9lCOAkjLV7xvKk0y3ZBG8QBxbymUJOx3B82NpW2VmKZCP1mWM6MG1cUC0ajn1fY62VX1A8LUh01K2nS3n9DdzjjUuFySrItIVxuN22pLF1BoX9QyL1At0WvHyOZA2CeMoCIXa12mFHtOLa22ECam336J0ZAVZAfzOYMZAUEcNpeJHrimEIUore1nzdS22yhFFuWmnwY9MZD"
      facebook = Koala::Facebook::API.new(token)
      @name = facebook.get_object('me')
      fb = User.find(1).update(:username => @name.fetch("name"))
      fb.save
      redirect_to new_user_registration_url
    end
  end
  # You should configure your model like this:
  # devise :omniauthable, omniauth_providers: [:twitter]

  # You should also create an action method in this controller like this:
  # def twitter
  # end

  # More info at:
  # https://github.com/plataformatec/devise#omniauth

  # GET|POST /resource/auth/twitter
  # def passthru
  #   super
  # end

  # GET|POST /users/auth/twitter/callback
  # def failure
  #   super
  # end

  # protected

  # The path used when omniauth fails
  # def after_omniauth_failure_path_for(scope)
  #   super(scope)
  # end
end
