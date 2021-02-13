require 'rails_helper'

RSpec.describe Friendship, type: :model do
  let(:current_user) { User.create(email: 'test_user@gmail.com', name: 'test_user', password: 'password') }
  let(:friend) { User.create(email: 'test_friend@gmail.com', name: 'test_friend', password: 'password') }

  it 'Test if friendship is valid' do
    friendship = Friendship.create(user_id: current_user.id, friend_id: friend.id)
    expect(friendship.valid?).to be true
  end

  it 'Test if friendship without user_id and friend_id is valid' do
    friendship = Friendship.create
    expect(friendship.valid?).to be false
  end

  it 'Test if friendship without user_id is valid' do
    friendship = Friendship.create(friend_id: friend.id)
    expect(friendship.valid?).to be false
  end

  it 'Test if friendship without friend_id is valid' do
    friendship = Friendship.create(user_id: current_user.id)
    expect(friendship.valid?).to be false
  end

  it 'Test if friendship created through  user is valid' do
    friendship = current_user.friendships.create(friend: friend)
    expect(friendship.valid?).to be true
  end

  it 'Test if friendship belongs to user' do
    friendship = current_user.friendships.create(friend: friend)
    expect(friendship.user).to eql(current_user)
  end

  it 'Test if duplicate freindship can be created' do
    friendship = current_user.friendships.create(friend: friend)
    friendship_duplicate = Friendship.new(user: current_user, friend: friend).save
    expect(friendship.user).to eql(current_user)
    expect(friendship_duplicate).to be false
  end

  it 'Test if friendship can be created again in the reversed order between same user pair' do
    friendship = current_user.friendships.create(friend: friend)
    friendship_reverse = Friendship.new(friend: friend, user: current_user).save
    expect(friendship.user).to eql(current_user)
    expect(friendship_reverse).to be false
  end
end
