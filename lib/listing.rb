require_relative './uploader'

class Listing < ActiveRecord::Base

  belongs_to :user
  belongs_to :booking_request

  mount_uploader :photo_src, Uploader
end
