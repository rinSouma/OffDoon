class CreateComments < ActiveRecord::Migration[5.1]
  def change
    create_table :comments do |t|
      t.string :comment
      t.references :event, foreign_key: true

      t.timestamps
    end
  end
end
