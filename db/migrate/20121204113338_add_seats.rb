class AddSeats < ActiveRecord::Migration
  def up
    add_column :users, :table, :string
    add_column :users, :seat, :string
  end

  def down
    remove_column :users, :table
    remove_column :users, :seat
  end
end
