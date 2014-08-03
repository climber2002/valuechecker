# == Schema Information
#
# Table name: daily_values
#
#  id                 :integer          not null, primary key
#  company_id         :integer
#  date               :date
#  total_shares       :integer
#  circulating_shares :integer
#  price              :decimal(7, 3)
#  pe_ttm             :decimal(9, 3)
#  pb                 :decimal(9, 3)
#  created_at         :datetime
#  updated_at         :datetime
#

class DailyValue < ActiveRecord::Base

  belongs_to :company
  validates :company_id, presence: true

  validates :date, presence: true, uniqueness: { scope: :company_id }

  validates :total_shares, presence: true
  validates :circulating_shares, presence: true
  validates :price, presence: true
  validates :pe_ttm, presence: true
  validates :pb, presence: true

  scope :by_date, ->(date){ where('date = ?', date)  }

  def market_value
    (total_shares.to_f * price.to_f)
  end

  def earnings_ttm
    return 0 if pe_ttm < 0.01
    market_value / pe_ttm
  end

  def books
    return 0 if pe_ttm < 0.01
    market_value / pb
  end
  
end
