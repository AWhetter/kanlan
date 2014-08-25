class AddSeatsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :table, :string
    add_column :users, :seat, :string
  end
end
