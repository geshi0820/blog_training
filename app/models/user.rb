class User < ActiveRecord::Base


  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :trackable, :validatable,:omniauthable,
  :authentication_keys => [:email,:username]

  has_many :articles, :dependent => :destroy
  has_many :comments, :dependent => :destroy
  has_many :favorites, :dependent => :destroy
  has_many :follows, :dependent => :destroy

  mount_uploader :image, ImageUploader



  #usernameを必須とする
  # validates :username, presence: true
  # validates :email, presence: true, uniqueness: true


  #usernameを利用してログインするようにオーバーライド
  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      #認証の条件式を変更する
      where(conditions).where(["username = :value", { :value => username }]).first
    else
      where(conditions).first
    end
  end

  def self.find_for_oauth(auth)
    user = User.where(uid: auth.uid, provider: auth.provider).first
    unless user
      user = User.create(
        uid:      auth.uid,
        provider: auth.provider,
        username: auth.info.name,
        email: User.get_email(auth),
        password: Devise.friendly_token[0, 20]
        )
    end

    user
  end

  def self.user_favorite_count(user_id)
    p Favorite.where(user_id: user_id).count
  end

  def self.user_follow_count(user_id)
    p Follow.where("user_id=?",user_id).count
  end

  def self.user_follower_count(user_id)
    p Follow.where("followed_id=?",user_id).count
  end

  def follow_name(followed_id)
    p User.find(followed_id).username
  end

  def user_follow_count(user_id)
    p Follow.where("user_id=?",user_id).count
  end

  def user_follower_count(user_id)
    p Follow.where("followed_id=?",user_id).count
  end

  def user_article_count(user_id)
    p Article.where(user_id: user_id).count
  end

  def author_name(article_id)
    user_id = Article.find(article_id).user_id
    User.find(user_id).username
  end

  def follow_or_not(followed_id,user_id)
    if Follow.where("user_id = ? and followed_id = ?", user_id, followed_id).pluck(:user_id,:followed_id).include?([user_id,followed_id])
      p 1
    else
      p 0
    end
  end

  def follow_id(followed_id,user_id)
    Follow.where(user_id: user_id, followed_id: followed_id).first.id
  end

  def self.follow_or_not(followed_id,user_id)
    if Follow.where("user_id = ? and followed_id = ?", user_id, followed_id).pluck(:user_id,:followed_id).include?([user_id,followed_id])
      p 1
    else
      p 0
    end
  end

  def self.follow_id(followed_id,user_id)
    Follow.where(user_id: user_id, followed_id: followed_id).first.id
  end

  private
  def self.get_email(auth)
    email = auth.info.email
    email = "#{auth.provider}-#{auth.uid}@example.com" if email.blank?
    email
  end
end