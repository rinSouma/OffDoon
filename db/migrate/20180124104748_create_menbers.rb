class CreateMenbers < ActiveRecord::Migration[5.1]
  def change
    create_table :menbers do |t|
      t.string :user
      t.integer :kbn
      t.references :event, foreign_key: true

      t.timestamps
    end
  end
end
