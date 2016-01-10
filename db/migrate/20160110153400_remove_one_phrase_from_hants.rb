class RemoveOnePhraseFromHants < ActiveRecord::Migration
  def change
    remove_column :hants, :one_phrase, :string
  end
end
