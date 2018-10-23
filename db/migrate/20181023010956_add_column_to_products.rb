class AddColumnToProducts < ActiveRecord::Migration[5.2]
  def change
    add_column :products, :is_active, :boolean, :default => true
  end
end
