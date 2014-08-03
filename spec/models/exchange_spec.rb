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
      ex = FactoryGirl.create(:exchange)
      ex2 = FactoryGirl.build(:exchange, name: ex.name)
      expect(ex2).to_not be_valid
      expect(ex2.errors[:name].size).to eq 1
    end
  end

end
