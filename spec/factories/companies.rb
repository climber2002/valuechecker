# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :company do
    code { Faker::Number.number(6) }
    name { Faker::Company.name }
    english_name { Faker::Company.name }

    after(:build) do |company|
      company.exchange = Exchange.find_by(abbreviation: 'SH')
    end
  end
end
