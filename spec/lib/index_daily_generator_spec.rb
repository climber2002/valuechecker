require 'rails_helper'

RSpec.describe IndexDailyGenerator do

  let(:index) { FactoryGirl.create(:index) }
  let(:company1) { FactoryGirl.create(:company) }
  let(:company2) { FactoryGirl.create(:company) }

  subject { described_class.new(index) }

  before :each do
    index.index_items.create(company: company1)
    index.index_items.create(company: company2)

    today = Date.today
    company1.daily_values.create(date: today, 
      total_shares: 1000, circulating_shares: 1000,
      price: 2, pe_ttm: 4, pb: 2)

    company2.daily_values.create(date: today, 
      total_shares: 3000, circulating_shares: 3000,
      price: 3, pe_ttm: 4, pb: 2)
  end

  describe '#generate_for_today' do
    context 'when the index_daily not exists' do
      
      it "should generate index daily correctly" do
        index_daily = subject.generate_for_today
        expect(index_daily.market_value).to eq(1000 * 2 + 3000 * 3)
        expect(index_daily.earnings_ttm).to eq((1000 * 2) / 4 + (3000 * 3) / 4)
        expect(index_daily.books).to eq((1000 * 2) / 2 + (3000 * 3) / 2)
      end
    end
  end

end