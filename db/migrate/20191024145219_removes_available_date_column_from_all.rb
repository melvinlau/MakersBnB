class RemovesAvailableDateColumnFromAll < ActiveRecord::Migration[6.0]
  def change
    change_table :listings do |t|
      t.remove :available_date
    end

    change_table :booking_requests do |t|
      t.remove :requested_date
    end

    change_table :bookings do |t|
      t.remove :requested_date
    end
  end
end
