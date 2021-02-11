class Post < ApplicationRecord
  validates :content, presence: true, length: { maximum: 1000,
                                                too_long: '1000 characters in post is the maximum allowed.' }

  belongs_to :user

  scope :ordered_by_most_recent, -> { order(created_at: :desc) }
  scope :user_and_friends, ->(user) { where(id: user.friends_group.map(&:id)).or(where(id: user.id)) }
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
end
