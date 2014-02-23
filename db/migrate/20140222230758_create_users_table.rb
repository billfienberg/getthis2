class CreateUsersTable < ActiveRecord::Migration
  def up
    create_table :users do |t|
      t.integer :user_num
      t.string :email
    end
  end

  def down
    drop_table :users
  end
end
