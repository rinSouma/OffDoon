class ChangeColumnNameEvents < ActiveRecord::Migration[5.1]
  def change
    rename_column :events, :user, :uid
  end
end
