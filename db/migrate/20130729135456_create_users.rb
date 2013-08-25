class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username
      t.string :ip
      t.references :seat, index: true

      t.timestamps
    end
  end
end
