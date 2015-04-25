class Admin::ArticlesController < ApplicationController
  before_action :set_article, only:[:show, :destroy] 
  def index
    @articles = Article.all.order("created_at ASC").includes(:user, :favorites)
  end

  def show
  end

  def show
    @comments = @article.comments
    @comment = @article.comments.build
  end

  def destroy_all_articles
  end

  private
  def set_article
    @article = Article.find(params[:id])    
  end  
end
