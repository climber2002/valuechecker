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

require 'rails_helper'

RSpec.describe Company, :type => :model do
  
  describe 'creation' do
    
    it "should be able to create a company" do
      expect(FactoryGirl.create(:company)).to be_valid
    end

    it "should be invalid if the exchange is nil" do
      company = FactoryGirl.create(:company)
      company.exchange = nil
      expect(company).to_not be_valid
    end

    it "should not allow empty name" do
      company = FactoryGirl.build(:company, name: nil)
      expect(company).to_not be_valid
      expect(company.errors[:name].size).to eq 1
    end

    it "should not allow duplicate name" do
      company = FactoryGirl.create(:company)
      company2 = FactoryGirl.build(:company, name: company.name)
      expect(company2).to_not be_valid
      expect(company2.errors[:name].size).to eq 1
    end    

    it "should allow english_name to be empty" do
      expect(FactoryGirl.create(:company, english_name: nil)).to be_valid
    end

    it "should not allow duplicate english_name" do
      company = FactoryGirl.create(:company)
      company2 = FactoryGirl.build(:company, english_name: company.english_name)
      expect(company2).to_not be_valid
      expect(company2.errors[:english_name].size).to eq 1
    end
  end

  describe "#exchange_english_name=" do
    
    it "should be able to set the exchange by exchange_english_name=" do
      shenzhen_exchange = FactoryGirl.create(:exchange, english_name: 'Shenzhen')
      company = FactoryGirl.create(:company, exchange: nil, exchange_english_name: shenzhen_exchange.english_name)
      expect(company.exchange_english_name).to eq shenzhen_exchange.english_name
    end

  end
end
