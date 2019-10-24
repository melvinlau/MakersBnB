class BookableDay < ActiveRecord::Base
  has_many :available_days
  has_many :listings, through: :available_days
end
