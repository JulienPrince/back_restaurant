class CreateRestaurants < ActiveRecord::Migration[6.0]
  def change
    create_table :restaurants do |t|
      t.string :nom_restaurant
      t.string :prix
      t.string :adress
      t.string :speciality
      t.belongs_to :users
      
      t.timestamps
    end
  end
end
