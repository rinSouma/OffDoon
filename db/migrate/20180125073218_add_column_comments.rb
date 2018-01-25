class AddColumnComments < ActiveRecord::Migration[5.1]
  def change
    add_column :comments, :uid, :string
  end
end
