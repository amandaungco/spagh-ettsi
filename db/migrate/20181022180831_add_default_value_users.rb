class AddDefaultValueUsers < ActiveRecord::Migration[5.2]
  def change
    change_column :users, :is_a_seller, :boolean, :default => false
  end
end
