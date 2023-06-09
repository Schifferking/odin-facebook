class Post < ApplicationRecord
  validates :title, presence: true
  validates :body, presence: true
  belongs_to :user
  has_many :likes
  has_many :comments

  def self.friend_posts(friends)
    Post.where(user_id: friends)
  end
end
