class ChangeCcToBigInt < ActiveRecord::Migration[5.2]
  def change
    change_column :payments, :card_number, :bigint
  end
end
s
