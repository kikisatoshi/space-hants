class CreateHants < ActiveRecord::Migration
  def change
    create_table :hants do |t|
      t.string :one_phrase
      t.string :content
      t.integer :study_evaluation, null: false, default: 0
      t.integer :pc_evaluation, null: false, default: 0
      t.integer :space_id
      t.integer :user_id

      t.timestamps null: false
      t.index [:space_id, :user_id], unique: true
    end
  end
end
