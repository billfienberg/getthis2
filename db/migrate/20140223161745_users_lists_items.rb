class UsersListsItems < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.integer :user_num
      t.string :email
    end

    create_table :lists do |t|
      t.integer :user_id
      t.string :name
      t.string :keyword
    end

    create_table :items do |t|
      t.belongs_to :list
      t.string :name
      t.integer :quantity
      t.boolean :completed
    end

    create_table :lists_users do |t|
      t.belongs_to :list
      t.belongs_to :user
    end
  end
end
