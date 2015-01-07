class AddNameIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :name_id, :string
  end
end
