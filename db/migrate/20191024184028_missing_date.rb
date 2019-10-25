class MissingDate < ActiveRecord::Migration[6.0]
  def change
    change_table :listings do |t|
      t.datetime :available_date
    end
  end
end
