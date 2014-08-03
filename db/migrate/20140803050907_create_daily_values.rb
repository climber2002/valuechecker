class CreateDailyValues < ActiveRecord::Migration
  def change
    create_table :daily_values do |t|
      t.references :company
      t.date       :date
      t.integer    :total_shares, limit: 8
      t.integer    :circulating_shares, limit: 8
      t.decimal    :price, precision: 7, scale: 3
      t.decimal    :pe_ttm, precision: 9, scale: 3  # PE TTM
      t.decimal    :pb, precision: 9, scale: 3
      t.timestamps
    end

    add_index :daily_values, [:company_id, :date], unique: true
  end
end
