class CreateSpaces < ActiveRecord::Migration
  def change
    create_table :spaces do |t|
      t.string :title
      t.string :description
      t.string :address
      t.float :latitude
      t.float :longitude
      t.string :category
      t.integer :user_id

      t.timestamps null: false
      t.index [:latitude, :longitude], unique: true
    end
  end
end
