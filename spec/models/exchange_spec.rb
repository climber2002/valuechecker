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

require 'rails_helper'

RSpec.describe Exchange, :type => :model do
  
  describe "creation" do
    it "should be able to create a valid exchange" do
      expect(FactoryGirl.create(:exchange)).to be_valid
    end

    it "should be invalid if the name is empty" do
      exchange = FactoryGirl.build(:exchange, name: '')
      expect(exchange).to_not be_valid
      expect(exchange.errors[:name].size).to eq 1
    end

    it "should be invalid if the name already exists" do
      FactoryGirl.create(:exchange)
      ex = FactoryGirl.build(:exchange)
      expect(ex).to_not be_valid
      expect(ex.errors[:name].size).to eq 1
    end
  end

  describe "db:seed" do
    it "should load seeds data" do
      expect(Exchange.find_by(abbreviation: 'SH').english_name).to eq 'Shanghai'
      expect(Exchange.find_by(abbreviation: 'SZ').english_name).to eq 'Shenzhen'
    end
  end

end
