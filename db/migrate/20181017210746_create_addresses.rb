class CreateAddresses < ActiveRecord::Migration[5.2]
  def change
    create_table :addresses do |t|
      t.references :user, foreign_key: true
      t.string :first_name
      t.string :last_name
      t.string :street
      t.string :street_2
      t.string :city
      t.string :state
      t.integer :zip
      
      t.timestamps
    end
  end
end
