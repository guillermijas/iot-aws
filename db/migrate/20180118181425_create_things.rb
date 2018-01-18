class CreateThings < ActiveRecord::Migration[5.1]
  def change
    create_table :things do |t|
      t.string :name
      t.string :status
      t.integer :desired_value

      t.timestamps
    end
  end
end