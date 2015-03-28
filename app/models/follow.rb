class Follow < ActiveRecord::Base
 belongs_to :user

 def user_follow_count(user_id)
    p Follow.where("user_id=?",user_id).count
end

def user_follower_count(user_id)
    p Follow.where("followed_id=?",user_id).count
end

def user_article_count(user_id)
    p Article.where(user_id: user_id).count
end

def follow_id(followed_id,user_id)
    Follow.where(user_id: user_id, followed_id: followed_id).first.id
end

def follow_name(followed_id)
    p User.find(followed_id).username
end

def follow_or_not(followed_id,user_id)
    if Follow.where("user_id = ? and followed_id = ?", user_id, followed_id).pluck(:user_id,:followed_id).include?([user_id,followed_id])
        p 1
    else
        p 0
    end
end


end
