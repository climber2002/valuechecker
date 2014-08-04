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

require 'rails_helper'

RSpec.describe Index, :type => :model do
  
  describe "creation" do
    it "should create a valid index" do
      expect(FactoryGirl.create(:index)).to be_valid
    end
  end

  describe "#company_by_code" do

    before :each do
      @index = FactoryGirl.create(:index)
      @index_item1 = FactoryGirl.create(:index_item, index: @index)
      @index_item2 = FactoryGirl.create(:index_item, index: @index)
    end

    it "should be able to get company by code" do
      expect(@index.company_by_code(@index_item1.company.code)).to eq @index_item1.company
    end

    it "should return nil if the company code not exist" do
      expect(@index.company_by_code("Nonexist")).to be_nil
    end
  end

end
