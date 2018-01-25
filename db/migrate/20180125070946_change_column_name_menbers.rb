class ChangeColumnNameMenbers < ActiveRecord::Migration[5.1]
  def change
    rename_table :menbers, :members
    rename_column :members, :user, :uid
  end
end
