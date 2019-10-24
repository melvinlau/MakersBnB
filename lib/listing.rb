class Listing < ActiveRecord::Base
  has_many :available_days
  has_many :bookable_days, through: :available_days
  belongs_to :user
  belongs_to :booking_request
end
