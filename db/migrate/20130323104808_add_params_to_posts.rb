class AddParamsToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :params, :string, :limit => 80
  end
end
