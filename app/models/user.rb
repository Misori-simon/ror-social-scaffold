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
  has_many :friends, -> { where(friendships: { status: true }) }, through: :friendships

  has_many :posts_from_friends, through: :friends, source: :posts

  def friend?(another_user)
    friendships.where(friend_id: another_user.id).first.present?
  end

  def friends_group
    friendships.where(status: true).map(&:friend) + Friendship.where(friend_id: id, status: true).map(&:user)
  end

  def request_friend(another_user_id)
    friendships.create(friend_id: another_user_id)
  end

  def accept_friend(another_user_id)
    friendship = Friendship.where(user_id: another_user_id, friend_id: id, status: false).first
    friendship.status = true
    friendship.save
  end

  def decline_friend(another_user_id)
    friendship = Friendship.where(user_id: another_user_id, friend_id: id, status: false).first
    friendship.destroy
  end

  def available_for_request?(another_user)
    clause = !friends_group.include?(another_user)
    clause &&= !friendships.where(friend_id: another_user.id, status: false).exists?
    clause && !Friendship.where(user_id: another_user.id, friend_id: id).exists?
  end

  def already_sent_request?(another_user)
    another_user.friendships.where(friend_id: id, status: false).exists?
  end
end
