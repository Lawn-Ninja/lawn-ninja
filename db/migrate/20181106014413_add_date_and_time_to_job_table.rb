class AddDateAndTimeToJobTable < ActiveRecord::Migration[5.2]
  def change
    add_column :jobs, :requested_time, :datetime
  end
end
