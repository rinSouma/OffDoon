class AddColumnEvent < ActiveRecord::Migration[5.1]
  def change
    add_column :events, :close_time, :datetime
  end
end
