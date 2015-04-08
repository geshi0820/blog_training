class User < ActiveRecord::Base
  devise :database_authenticatable, 
         :recoverable, 
         :rememberable, 
         :validatable,
         :omniauthable,
         :authentication_keys => [:username]

  has_many :articles, 
            dependent: :destroy, 
            through: :favorites

  has_many :comments, 
            dependent: :destroy

  has_many :favorites, 
            dependent: :destroy

  has_many :follows, 
            dependent: :destroy 

  has_many :reverse_follows, 
            foreign_key: "followed_id",
            class_name:  "Follow",
            dependent: :destroy

  mount_uploader :image, ImageUploader

  def user_image
    user = User.find(self)
    if user.image.blank?
      if user.uid
        uid = user.uid.to_s
        "https://graph.facebook.com/"+uid+"/picture?type=square"
      else
        "http://www.oomoto.or.jp/japanese/_src/sc6732/90l95A883A83C83R8393.jpg"
      end
    else
      user.image_url(:thumb).to_s
    end
  end
  
  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
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
        email: auth.info.email,
        password: Devise.friendly_token[0, 20]
        )
    end
    user
  end 
end



