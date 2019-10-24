class AddDayIdToBookingRequestsAndBookings < ActiveRecord::Migration[6.0]
  def change
    change_table :bookings do |t|
      t.belongs_to :bookable_day
    end
    change_table :booking_requests do |t|
      t.belongs_to :bookable_day
    end
  end
end
