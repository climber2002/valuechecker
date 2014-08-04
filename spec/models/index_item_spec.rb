# == Schema Information
#
# Table name: index_items
#
#  id         :integer          not null, primary key
#  index_id   :integer
#  company_id :integer
#  weight     :decimal(5, 3)
#  created_at :datetime
#  updated_at :datetime
#

require 'rails_helper'

RSpec.describe IndexItem, :type => :model do
  
  describe "creation" do
    
    it "should be able to create a valid index item" do
      expect(FactoryGirl.create(:index_item)).to be_valid
    end

    it "should not allow the same company to be added in index multiple times" do
      index_item = FactoryGirl.create(:index_item)
      another = FactoryGirl.build(:index_item, index: index_item.index, company: index_item.company)
      expect(another).to_not be_valid
      expect(another.errors[:company_id]).to eq ['has already been taken']
    end
  end

end
