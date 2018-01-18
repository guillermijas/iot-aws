class CreateLogs < ActiveRecord::Migration[5.1]
  def change
    create_table :logs do |t|
      t.belongs_to :thing, foreign_key: true
      t.string :action

      t.timestamps
    end
  end
end
