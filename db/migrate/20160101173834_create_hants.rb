class CreateHants < ActiveRecord::Migration
  def change
    create_table :hants do |t|
      t.string :one_phrase
      t.string :content
      t.integer :study_evaluation
      t.integer :pc_evaluation

      t.timestamps null: false
    end
  end
end
