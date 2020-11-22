class AddRestaurantIdToComments < ActiveRecord::Migration[6.0]
  def change
    add_column :comments, :restaurant_id, :integer
    add_column :comments, :user_id, :integer
  end
end
