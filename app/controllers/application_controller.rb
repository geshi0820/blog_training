class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  before_action :authenticate_user!
  before_filter :configure_permitted_parameters, if: :devise_controller?

  class UserController < ApplicationController
    include CarrierwaveBase64Uploader

    def update
      raise ArgumentError, 'invalid params' if params[:name].blank? || params[:profile].blank?
      user = User.find_or_create_by(name: params[:name])
      user.profile_image = params[:profile]
      user.save!
      render json: {
        name: user.name,
        profile_url: user.profile_image.url
      }
    end

    def update_base64
      raise ArgumentError, 'invalid params' if params[:name].blank? || params[:profile].blank?
      user = User.find_or_create_by(name: params[:name])
      user.profile_image = base64_conversion(params[:profile_base64])
      user.save!
      render json: {
        name: user.name,
        profile_url: user.profile_image.url
      }
    end
  end

  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) do |u|
      u.permit(:id,:username,:password,:email,:image)
    end 
    devise_parameter_sanitizer.for(:account_update) do |u|
      u.permit(:id,:username,:password,:email,:image,:password_confirmation,:current_password) 
    end 
  end
end