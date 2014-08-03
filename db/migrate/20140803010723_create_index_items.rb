class CreateIndexItems < ActiveRecord::Migration
  def change
    create_table :index_items do |t|
      t.references :index
      t.references :company
      t.decimal :weight, precision: 5, scale: 3
      t.timestamps
    end
  end
end
