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
end
