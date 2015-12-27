class ChangeLoacationOptionsToUsers < ActiveRecord::Migration
  def change
    rename_column :users, :location, :hometown
  end
end
