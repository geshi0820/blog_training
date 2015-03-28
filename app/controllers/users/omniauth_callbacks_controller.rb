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
      token = "CAAWF8XmmjJEBAI2bTSdbm0UWBWcBgFB1DZCCGD6yM4ZAqYfjmyZB7JFyiQGSsFNZBmtw2LWWkz3qmbt7QmgZC8doxMyECRLRb6GpXGdhnXC7HIt9vFPZAB0bsGaKOqFco9HoKYFuSykHRbB6yHQWZC8LtRGOxssIxPywp5rwoGHKUPXLiTw6oYR3JzFzcAWO7fs5UsD4rhLa1OiR5Y3WDxd"
      facebook = Koala::Facebook::API.new(token)
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
