class CreateItemsTable < ActiveRecord::Migration
  def up
    create_table :items do |t|
      t.integer :list_id
      t.string :name
      t.integer :quantity
      t.boolean :completed
    end
  end

  def down
    drop_table :items
  end
end
