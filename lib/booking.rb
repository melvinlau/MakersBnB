class Booking < ActiveRecord::Base
  belongs_to :user

  def self.get_user_bookings(user_id:)
    bookings = Booking.where(user_id: user_id)
    booking_info = []
    bookings.each { |bk|
      listing = Listing.find_by(id: bk.listing_id)
      booking_info.push( {
        listing_name: listing.name,
        location: listing.location,
        requested_date: BookableDay.find_by(id: bk.bookable_day_id).days,
        ls_id: bk.listing_id,
        bk_id: bk.id
      })
    }
    booking_info
  end
end
