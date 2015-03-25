class User < ActiveRecord::Base


  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :trackable, :validatable,:omniauthable,
  :authentication_keys => [:email,:username]

  has_many :articles
  has_many :comments
  has_many :favorites
  has_many :follows

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
        image: auth[:info][:image], 
        password: Devise.friendly_token[0, 20]
        )
    end

    user
  end


private
def self.get_email(auth)
  email = auth.info.email
  email = "#{auth.provider}-#{auth.uid}@example.com" if email.blank?
  email
end
end