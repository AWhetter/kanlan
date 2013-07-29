class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username
      t.string :ip
      t.string :table
      t.string :seat

      t.timestamps
    end
  end
end
