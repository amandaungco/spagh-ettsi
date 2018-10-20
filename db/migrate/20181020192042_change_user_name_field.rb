class ChangeUserNameField < ActiveRecord::Migration[5.2]
    def change
      remove_column :users, :first_name
      remove_column :users, :last_name
      add_column :users, :full_name, :string
    end
end
