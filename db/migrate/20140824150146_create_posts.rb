class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.references :game, index: true
      t.string :params

      t.timestamps
    end
  end
end
