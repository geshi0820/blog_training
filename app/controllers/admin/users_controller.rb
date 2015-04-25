class Admin::UsersController < ApplicationController
  before_action :set_user, only: [:show, :destroy]
  def index
    @users = User.all
  end

  def show
  end

  def destroy
    @user.destroy
    redirect_to :back
  end

  def destroy_all_user
    User.all.destroy_all
    redirect_to :back
  end

  private
  def set_user
    @user = User.find(params[:id])
  end
end
