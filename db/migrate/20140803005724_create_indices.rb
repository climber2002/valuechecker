class CreateIndices < ActiveRecord::Migration
  def change
    create_table :indices do |t|
      t.string :code
      t.string :name
      t.string :english_name
      t.timestamps
    end
  end
end
