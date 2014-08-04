# == Schema Information
#
# Table name: exchanges
#
#  id           :integer          not null, primary key
#  name         :string(255)
#  abbreviation :string(255)
#  english_name :string(255)
#  created_at   :datetime
#  updated_at   :datetime
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :exchange do
    name            { Faker::Company.name }
    abbreviation    { Faker::Company.name.gsub(/\s/, '')[0, 2] }
    english_name    { Faker::Company.name }
  end
end
