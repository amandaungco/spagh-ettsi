class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.boolean :is_a_seller
      t.integer :uid
      t.string :provider

      t.timestamps
    end
  end
end
