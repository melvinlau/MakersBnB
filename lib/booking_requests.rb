require_relative 'listing'
require_relative 'user'

class BookingRequest < ActiveRecord::Base
  belongs_to :user
  has_many :listings

  def self.get_user_requests(user_id:)
    booking_requests = BookingRequest.where(user_id: user_id)
    requests = []
    booking_requests.each { |br|
      requests.push( {
        listing_name: Listing.find_by(id: br.listing_id).name,
        guest: User.find_by(id: br.guest).name,
        requested_date: BookableDay.find_by(id: br.bookable_day_id).days,
        br_id: br.id
      })
    }
    requests
  end

  def self.confirm(id:)
    br = BookingRequest.find_by(id: id)
    Booking.create(
      user_id: br.guest,
      requested_date: br.requested_date,
      listing_id: br.listing_id
    )
    BookingRequest.delete(br.id)
  end
end
