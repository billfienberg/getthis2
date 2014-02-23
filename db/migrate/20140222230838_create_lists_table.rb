class CreateListsTable < ActiveRecord::Migration
  def up
    create_table :lists do |t|
      t.integer :user_id
      t.string :name
      t.string :keyword

    end
  end

  def down
    drop_table :lists
  end
end
