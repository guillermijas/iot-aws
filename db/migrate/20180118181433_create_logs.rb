class CreateLogs < ActiveRecord::Migration[5.1]
  def change
    create_table :logs do |t|
      t.integer :status
      t.integer :temperature
      t.integer :light
      t.boolean :presence

      t.timestamps
    end
  end
end
