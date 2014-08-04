class CreateCompanies < ActiveRecord::Migration
  def change
    create_table :companies do |t|
      t.string :code
      t.string :name
      t.string :english_name
      t.references :exchange
      t.timestamps
    end
  end
end
