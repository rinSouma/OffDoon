class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :uid
      t.string :display_name
      t.string :avatar
      t.string :url
      t.string :token

      t.timestamps
    end
  end
end
