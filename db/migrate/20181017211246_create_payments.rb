class CreatePayments < ActiveRecord::Migration[5.2]
  def change
    create_table :payments do |t|
      t.references :user, foreign_key: true
      t.references :address, foreign_key: true
      t.integer :card_number
      t.date :expiration_date
      t.integer :cvv
      t.string :card_type

      t.timestamps
    end
  end
end
