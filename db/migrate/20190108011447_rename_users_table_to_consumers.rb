class RenameUsersTableToConsumers < ActiveRecord::Migration[5.2]
  def change
    rename_table :users, :consumers

    remove_column :consumers, :name, :string
    remove_column :consumers, :provider, :boolean
    add_column :consumers, :first_name, :string
    add_column :consumers, :last_name, :string


  end
end
