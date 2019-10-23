class CreateImagesTable < ActiveRecord::Migration[6.0]
  def change
    create_table :images do |t|
      t.belongs_to :listing
      t.string :image
    end
  end
end
