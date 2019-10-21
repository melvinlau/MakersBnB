class CreateListingsTable < ActiveRecord::Migration[6.0]
  def change
    create_table :listings do |t|
      t.string :name
      t.string :description
      t.float :price
      t.string :location
      t.string :photo_src
      t.datetime :available_date
      t.integer :user_id
    end
  end
end
