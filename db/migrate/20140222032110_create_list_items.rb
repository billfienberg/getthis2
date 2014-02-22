class CreateListItems < ActiveRecord::Migration
  def up
    create_table :items do |t|
      t.string :itemname
      t.integer :quantity
      t.boolean :completed
    end
  end

  def down
    drop_table :items
  end
end
