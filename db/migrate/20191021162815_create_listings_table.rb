class CreateListingsTable < ActiveRecord::Migration[6.0]
  def change
    create_table :listings do |t|
      t.belongs_to :user
      t.has_many :uploads
      t.string :name
      t.string :description
      t.float :price
      t.string :location
      t.string :upload_id
      t.datetime :available_date
    end
  end
end
