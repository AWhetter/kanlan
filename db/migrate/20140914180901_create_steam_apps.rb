class CreateSteamApps < ActiveRecord::Migration
  def change
    create_table :steam_apps do |t|
      t.string :name

      t.timestamps
    end
  end
end
