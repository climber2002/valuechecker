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

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :index_item do
    association :index
    association :company
  end
end
