class AddColumnsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :name, :string
    add_column :users, :profile, :string
    add_column :users, :hometown, :string
  end
end
