class CreateGamePostsJoin < ActiveRecord::Migration
  def up
    create_table :games_posts, :id => false do |t|
      t.references :game
      t.references :post
    end
    add_index :games_posts, [:game_id, :post_id]
    add_index :games_posts, [:post_id, :game_id]
  end

  def down
    drop_table :games_posts
  end
end
