# == Schema Information
#
# Table name: indices
#
#  id           :integer          not null, primary key
#  code         :string(255)
#  name         :string(255)
#  english_name :string(255)
#  created_at   :datetime
#  updated_at   :datetime
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :index do
    code { Faker::Number.number(6) }
    name { Faker::Company.name}
    english_name { Faker::Company.name }
  end
end
