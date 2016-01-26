class AddPasswordToDataLinks < ActiveRecord::Migration
  def change
    add_column :data_links, :password, :string
  end
end
