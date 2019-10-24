class AvailableDay < ActiveRecord::Base
  belongs_to :bookable_day
  belongs_to :listing
end
