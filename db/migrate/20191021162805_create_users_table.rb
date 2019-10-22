class CreateUsersTable < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.has_many :listings
      t.has_many :bookings
      t.string :email
      t.string :password
      t.string :name
    end
  end
end
