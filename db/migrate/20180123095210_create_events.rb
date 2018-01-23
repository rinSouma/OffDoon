class CreateEvents < ActiveRecord::Migration[5.1]
  def change
    create_table :events do |t|
      t.string :title
      t.text :detail
      t.string :place
      t.string :url
      t.datetime :date
      t.integer :limit
      t.string :user
      t.integer :view

      t.timestamps
    end
  end
end
