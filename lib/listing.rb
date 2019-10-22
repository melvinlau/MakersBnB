class Listing < ActiveRecord::Base
  belongs_to :user
  belongs_to :booking_request
end
