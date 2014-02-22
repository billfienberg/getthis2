class MakeListsTable < ActiveRecord::Migration
  def up
    create_table :lists do |t|
      t.string :name
      t.string :keyword
    end
  end

  def down
    drop_table :lists
  end
end
