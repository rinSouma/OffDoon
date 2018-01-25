class AddColumnUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :domain, :string
  end
end
