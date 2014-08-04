require 'rails_helper'

RSpec.describe Xueqiu::CompanyDailyValuePopulator do

  describe "#populate_for_today" do
    
    before :each do
       Timecop.freeze('2014-08-01')

       allow_any_instance_of(Xueqiu::CompanyParser).to receive(:parse_daily_value).and_return( 
        { 
          date: Date.today,
          total_shares: 2_000_000,
          circulating_shares: 900_000,
          price: 3.80,
          pe_ttm: 5.0,
          pb: 1.5
        } 
      )
    end

    after :each do
      Timecop.return
    end

    it "shouldn't populate if the value for today already exists" do
      daily_value = FactoryGirl.create(:daily_value, date: Date.today)
      company = daily_value.company

      expect(described_class.new(company).populate_for_today).to eq false

      company.reload
      expect(company.daily_value_on(Date.today).total_shares).to_not eq 2_000_000
    end

    it "should populate if the value for today not exists" do
      company = FactoryGirl.create(:company)
      expect(described_class.new(company).populate_for_today).to_not eq false

      company.reload
      expect(company.daily_value_on(Date.today).total_shares).to eq 2_000_000            
    end
  end

end