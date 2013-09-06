class LinkPostsUsers < ActiveRecord::Migration
  def change
    create_table :posts_users, :id => false do |t|
      t.references :post
      t.references :user
    end

    add_index :posts_users, [ :post_id, :user_id ], :unique => true
  end
end
