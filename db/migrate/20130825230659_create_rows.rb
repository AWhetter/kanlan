class CreateRows < ActiveRecord::Migration
  def change
    create_table :rows do |t|
      t.references :table_group, index: true

      t.timestamps
    end
  end
end
