# == Schema Information
#
# Table name: companies
#
#  id           :integer          not null, primary key
#  code         :string(255)
#  name         :string(255)
#  english_name :string(255)
#  exchange_id  :integer
#  created_at   :datetime
#  updated_at   :datetime
#

class Company < ActiveRecord::Base

  validates :code, presence: true, uniqueness: true
  validates :name, presence: true, uniqueness: true
  validates :english_name, uniqueness: { allow_blank: true }

  belongs_to :exchange
  validates :exchange_id, presence: true

  has_many :daily_values

  def exchange_english_name=(exchange_name)
    self.exchange = Exchange.find_by(english_name: exchange_name)
  end

  def exchange_english_name
    self.exchange.english_name
  end

  def daily_value_on(date)
    daily_values.by_date(date).first
  end
end
