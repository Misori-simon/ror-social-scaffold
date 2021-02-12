class Friendship < ApplicationRecord
  before_create :friendship_exist?

  belongs_to :user
  belongs_to :friend, class_name: 'User'

  scope :normal_friendship_order, ->(friendship) { where(user_id: friendship.user_id, friend_id: friendship.friend_id) }
  scope :reverse_friendship_order, ->(friendship) { where(user_id: friendship.friend_id, friend_id: friendship.user_id) }
  private

  def friendship_exist?
    unless Friendship.normal_friendship_order(self).empty? && Friendship.reverse_friendship_order(self).empty?
      errors.add(:base, "Friendship has already been sent")
      throw(:abort)
    end
  end
end
