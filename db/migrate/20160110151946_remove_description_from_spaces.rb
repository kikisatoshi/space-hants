class RemoveDescriptionFromSpaces < ActiveRecord::Migration
  def change
    remove_column :spaces, :description, :string
  end
end
