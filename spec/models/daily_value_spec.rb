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

require 'rails_helper'

RSpec.describe DailyValue, :type => :model do
  
  describe "creation" do
    
    it "should be able to create a daily value from FactoryGirl" do
      expect(FactoryGirl.create(:daily_value)).to be_valid
    end

    it "shouldn't have two daily value " do
      dv = FactoryGirl.create(:daily_value)
      another = FactoryGirl.build(:daily_value, company: dv.company, date: dv.date)
      expect(another).to_not be_valid
      expect(another.errors[:date].size).to eq 1
    end

  end

  describe "calculate" do
    
    subject { FactoryGirl.create(:daily_value) }

    it "should generate valid market value" do
      expect(subject.market_value).to eq 1_000_000 * 8.0
    end

    it "should generate valid total earnings" do
      expect(subject.earnings_ttm).to eq 8_000_000 / 4.0
    end

    it "should generate valid total books" do
      expect(subject.books).to eq 8_000_000 / 2.0
    end
  end
  
  describe ".by_date" do
    
    subject { FactoryGirl.create(:daily_value) }

    it "shuld be able to find by_date" do
      company = subject.company
      expect(company.daily_values.by_date(subject.date).first).to eq subject
    end    
  end  
end
