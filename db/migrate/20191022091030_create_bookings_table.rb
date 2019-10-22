class CreateBookingsTable < ActiveRecord::Migration[6.0]
  def change
    create_table :bookings do |t|
      t.belongs_to :user
      t.belongs_to :listing
      t.datetime :requested_date
    end
  end
end
