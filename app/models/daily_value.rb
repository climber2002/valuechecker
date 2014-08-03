class DailyValue < ActiveRecord::Base

  belongs_to :company
  validates :company_id, presence: true

  validates :date, uniqueness: { scope: :company_id }

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
