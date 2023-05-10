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
end
