class AvailableDay < ActiveRecord::Base
  belongs_to :bookable_day
  belongs_to :listing

  def self.new_listing_days(listing_id:, days_hash:)
    days_hash.each { |id, _day|
      AvailableDay.create(listing_id: listing_id, bookable_day_id: id)
    }
  end
end
