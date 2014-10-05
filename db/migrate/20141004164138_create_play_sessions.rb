class CreatePlaySessions < ActiveRecord::Migration
  def change
    create_table :play_sessions do |t|
      t.references :user, index: true
			t.integer :steam_app_id
			t.string :game_name
      t.datetime :started_at
      t.datetime :finished_at

      t.timestamps
    end
  end
end
