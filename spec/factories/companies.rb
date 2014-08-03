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

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :company do
    code { Faker::Number.number(6) }
    name { Faker::Company.name }
    english_name { Faker::Company.name }
    association :exchange
  end
end
