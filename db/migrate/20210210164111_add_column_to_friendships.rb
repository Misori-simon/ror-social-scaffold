class AddColumnToFriendships < ActiveRecord::Migration[5.2]
  def change
    add_column :friendships, :status, :boolean, default: true
  end
end
