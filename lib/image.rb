require_relative './uploader'

class Image < ActiveRecord::Base
  mount_uploader :image, Uploader
end
