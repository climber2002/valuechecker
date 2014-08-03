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

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :index_daily do
    association     :index
    date            { Date.today }
    market_value    { 4_000_000 }
    earnings_ttm    { 1_000_000 }
    books           { 2_000_000 }
    
  end
end
