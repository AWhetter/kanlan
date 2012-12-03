class RecordUsersIp < ActiveRecord::Migration
  def up
    add_column :users, :ip, :string
  end

  def down
    remove_column :users, :ip
  end
end
