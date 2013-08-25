class CreateTables < ActiveRecord::Migration
  def change
    create_table :tables do |t|
      t.references :row, index: true
      t.references :table_group, index: true

      t.timestamps
    end
  end
end
