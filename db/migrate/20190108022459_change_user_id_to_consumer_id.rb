class ChangeUserIdToConsumerId < ActiveRecord::Migration[5.2]
  def change
    remove_column :jobs, :user_id, :integer
    add_column :jobs, :consumer_id, :integer
  end
end
