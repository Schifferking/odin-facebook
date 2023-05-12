class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true
  validates :gender, presence: true
  validates :color, presence: true
  validates :email, presence: true
  validates :password, presence: true, length: { in: 6..20 }
  has_many :posts
  has_many :likes
  has_many :comments
  has_many :requests_sent, foreign_key: "requester_id", class_name: "Relationship"
  has_many :requests_received, foreign_key: "requested_id", class_name: "Relationship"
end
