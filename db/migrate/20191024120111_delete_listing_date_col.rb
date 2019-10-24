class DeleteListingDateCol < ActiveRecord::Migration[6.0]
  def change
    change_table :listings do |t|
      t.remove :available_date
    end
  end
end
