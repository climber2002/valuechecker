# == Schema Information
#
# Table name: index_items
#
#  id         :integer          not null, primary key
#  index_id   :integer
#  company_id :integer
#  weight     :decimal(5, 3)
#  created_at :datetime
#  updated_at :datetime
#

class IndexItem < ActiveRecord::Base

  belongs_to :index

  belongs_to :company
  validates :company_id, presence: true, uniqueness: { scope: :index_id }

end
