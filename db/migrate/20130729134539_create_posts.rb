class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.belongs_to :game
      t.string :params

      t.timestamps
    end
  end
end
