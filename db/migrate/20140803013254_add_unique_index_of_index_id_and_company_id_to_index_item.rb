class AddUniqueIndexOfIndexIdAndCompanyIdToIndexItem < ActiveRecord::Migration
  def change
    add_index :index_items, [:index_id, :company_id], unique: true
  end
end
