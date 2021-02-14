require 'rails_helper'

RSpec.describe User, type: :model do
  let(:current_user) { User.create(email: 'test_user@gmail.com', name: 'test_user', password: 'password') }
  let(:friend) { User.create(email: 'test_friend@gmail.com', name: 'test_friend', password: 'password') }
  let(:no_email_user) { User.create(name: 'test_user', password: 'password') }
  let(:no_name_user) { User.create(email: 'test_user@gmail.com', password: 'password') }
  let(:no_password_user) { User.create(email: 'test_user@gmail.com', name: 'test_user') }

  it 'Test if user is valid' do
    expect(current_user.valid?).to be true
  end

  it 'Test if user without email is valid' do
    expect(no_email_user.valid?).to be false
  end

  it 'Test if user without name is valid' do
    expect(no_name_user.valid?).to be false
  end

  it 'Test if user without password is valid' do
    expect(no_password_user.valid?).to be false
  end

  it 'Test if user can send friend request' do
    friendship = current_user.request_friend(friend.id)
    expect(Friendship.all.include?(friendship)).to be true
  end

  it 'Test if user can accept friend request' do
    current_user.request_friend(friend.id)
    friend.accept_friend(current_user.id)
    friendship = current_user.friendships.where(friend_id: friend.id).first
    expect(friendship.status).to eql(true)
  end

  it 'Test if user can decline friend request' do
    friendship = current_user.request_friend(friend.id)
    friend.decline_friend(current_user.id)
    expect(Friendship.all.include?(friendship)).to be false
  end
end
