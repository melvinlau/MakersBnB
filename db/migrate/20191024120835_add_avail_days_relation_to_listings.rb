class AddAvailDaysRelationToListings < ActiveRecord::Migration[6.0]
  def change
    create_table :available_days do |t|
      t.belongs_to :listing
      t.belongs_to :bookable_day
    end

    create_table :bookable_days do |t|
      t.datetime :days
    end
  end
end
