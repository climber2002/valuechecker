class CreateExchanges < ActiveRecord::Migration
  def change
    create_table :exchanges do |t|
      t.string :name
      t.string :abbreviation
      t.string :english_name
      t.timestamps
    end
  end
end
