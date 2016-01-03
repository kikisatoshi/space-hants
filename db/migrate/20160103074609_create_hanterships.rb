class CreateHanterships < ActiveRecord::Migration
  def change
    create_table :hanterships do |t|
      t.references :user, index: true
      t.references :hant, index: true
      t.string :type

      t.timestamps null: false
      t.index [:user_id, :hant_id , :type], unique: true
    end
  end
end
