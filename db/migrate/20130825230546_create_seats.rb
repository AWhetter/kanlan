class CreateSeats < ActiveRecord::Migration
  def change
    create_table :seats do |t|
      t.string :name
      t.references :table, index: true

      t.timestamps
    end
  end
end