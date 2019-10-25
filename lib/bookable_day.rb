class BookableDay < ActiveRecord::Base
  has_many :available_days
  has_many :listings, through: :available_days

  def self.generate(today:)
    for d in (1..15) do
      day = today + d.day
      unless BookableDay.find_by(days: day)
        BookableDay.create(days: day)
      end
    end
  end
end
