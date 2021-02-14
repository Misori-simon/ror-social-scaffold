class Friendship < ApplicationRecord
  before_create :friendship_exist?

  belongs_to :user
  belongs_to :friend, class_name: 'User'

  scope :normal_friendship_order, ->(f) { where(user_id: f.user_id, friend_id: f.friend_id) }
  scope :reverse_friendship_order, ->(f) { where(user_id: f.friend_id, friend_id: f.user_id) }
  private

  def friendship_exist?
    return if Friendship.normal_friendship_order(self).empty? && Friendship.reverse_friendship_order(self).empty?

    errors.add(:base, 'Friendship has already been sent')
    throw(:abort)
  end
end
