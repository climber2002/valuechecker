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

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :daily_value do
    association               :company
    date                      { Date.today }
    total_shares              1_000_000
    circulating_shares        900_000
    price                     8.0
    pe_ttm                    4.0
    pb                        2.0
  end
end
