class CreateDataLinks < ActiveRecord::Migration
  def change
    create_table :data_links do |t|
      t.integer :vol
      t.string :link

      t.timestamps null: false
    end

    add_index :data_links, :vol
  end
end
