class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.string :name, presence: true, unique: true
      t.string :url
      t.integer :steam_app_id, unique: true

      t.timestamps
    end
    #add_index :games, :name, unique: true
    #add_index :games, :steam_app_id, unique: true
  end
end
