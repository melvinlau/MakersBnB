require_relative 'listing'
require_relative 'user'

class BookingRequest < ActiveRecord::Base
  belongs_to :user
  has_many :listings

  def self.get_user_bookings(user_id:)
    booking_requests = BookingRequest.where(user_id: user_id)
    requests = []
    booking_requests.each { |br|
      requests.push( {
        listing_name: Listing.find_by(id: br.listing_id).name,
        guest: User.find_by(id: br.guest).name,
        requested_date: br.requested_date,
        br_id: br.id
      })
    }
    requests
  end
end
