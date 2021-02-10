class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { maximum: 20 }

  has_many :posts
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  has_many :friendships, dependent: :destroy
  has_many :friends, through: :friendships

  has_many :posts_from_friends, through: :friends, source: :posts

  def is_friend?(another_user)
    self.friendships.where(friend_id: another_user.id).first.present?
  end

  def friends_group
    self.friendships + Friendship.where(friend_id: self.id)
  end

  def add_friend(another_user)
    self.friendships.create(friend_id: another_user.id)
  end
end
