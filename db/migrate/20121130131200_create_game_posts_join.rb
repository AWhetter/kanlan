class CreateGamePostsJoin < ActiveRecord::Migration
  def up
    create_table 'games_posts', :id => false do |t|
      t.integer :game_id
      t.integer :post_id
    end
  end

  def down
    drop_table 'games_posts'
  end
end
