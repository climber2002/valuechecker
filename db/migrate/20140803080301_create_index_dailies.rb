class CreateIndexDailies < ActiveRecord::Migration
  def change
    create_table :index_dailies do |t|
      t.references :index
      t.date       :date
      t.decimal    :market_value, precision: 25, scale: 3
      t.decimal    :earnings_ttm, precision: 25, scale: 3
      t.decimal    :books, precision: 25, scale: 3
      t.timestamps
    end

    add_index :index_dailies, [:index_id, :date], unique: true
  end
end
