class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.string :name
      t.references :user, foreign_key: true
      t.integer :price_in_cents
      t.integer :quantity
      t.string :category
      t.text :description

      t.timestamps
    end
  end
end
