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

require 'rails_helper'

RSpec.describe IndexDaily, :type => :model do
  
  describe '#pe_ttm' do
    
    it "should calculate pe correctly" do
      index_daily = FactoryGirl.create(:index_daily)
      expect(index_daily.pe_ttm).to eq 4.0
    end
  end

  describe '#pb' do
    
    it "should calculate pb correctly" do
      index_daily = FactoryGirl.create(:index_daily)
      expect(index_daily.pb).to eq 2.0
    end
  end

end
