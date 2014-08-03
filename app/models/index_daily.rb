# == Schema Information
#
# Table name: index_dailies
#
#  id           :integer          not null, primary key
#  index_id     :integer
#  date         :date
#  market_value :decimal(25, 3)
#  earnings_ttm :decimal(25, 3)
#  books        :decimal(25, 3)
#  created_at   :datetime
#  updated_at   :datetime
#

class IndexDaily < ActiveRecord::Base

  belongs_to :index
  validates :index_id, presence: true

  validates :date, presence: true, uniqueness: { scope: :index_id }
  validates :earnings_ttm, presence: true
  validates :books, presence: true
  validates :market_value, presence: true

  def pe_ttm
    market_value.to_f / earnings_ttm
  end

  def pb
    market_value.to_f / books
  end

end
