class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.decimal :lat, precision: 9, scale: 6
      t.decimal :lng, precision: 9, scale: 6
      t.text :description
      t.string :tags, array: true, default: []
      t.attachment :file
      t.integer :user_id, null: false
      t.timestamps null: false
    end
  end
end
