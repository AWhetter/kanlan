class CreateTableGroups < ActiveRecord::Migration
  def change
    create_table :table_groups do |t|
      t.string :name
      t.references :left_end_table, index: true
      t.references :right_end_table, index: true

      t.timestamps
    end
  end
end
