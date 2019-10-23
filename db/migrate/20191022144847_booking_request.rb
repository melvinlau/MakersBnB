class BookingRequest < ActiveRecord::Migration[6.0]
  def change
    create_table :booking_requests do |t|
      t.belongs_to :user
      t.belongs_to :listing
      t.string :guest
      t.datetime :requested_date
    end
  end
end
