class AddStypeToDataLinks < ActiveRecord::Migration
  def change
    add_column :data_links, :stype, :string, default: ''
  end
end
