class CreateReserveds < ActiveRecord::Migration[6.0]
  def change
    create_table :reserveds do |t|
      t.string :user_email
      t.references :users, foreign_key: true
      t.references :restaurant, foreign_key: true
      t.datetime :reservation
    end
  end
end
