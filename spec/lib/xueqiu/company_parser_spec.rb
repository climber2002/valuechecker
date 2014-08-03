require 'rails_helper'

RSpec.describe Xueqiu::CompanyParser do

  describe '#parse_daily_value' do
    
    let(:company) { FactoryGirl.create(:company) }
    subject { described_class.new(company) }

    before :each do
      stub_request(:get, subject.company_url).
        to_return(:status => 200, :body => company_html, :headers => {})

      stub_request(:get, subject.capital_structure_url).
        to_return(:status => 200, :body => capital_structure_html, :headers => {})

      stub_request(:get, subject.capital_structure_json_url).
        to_return(:status => 200, :body => capital_structure_json, :headers => {})

    end

    context "when it's normal" do
      let(:company_html) { File.read("#{Rails.root}/spec/request_mock/SZ000001.html") }
      let(:capital_structure_html) { File.read("#{Rails.root}/spec/request_mock/SZ000001_GBJG.html") }
      let(:capital_structure_json) { File.read("#{Rails.root}/spec/request_mock/SZ000001.json") }
      
      it "should use today's price" do
        hash = subject.parse_daily_value
        expect(hash[:price]).to eq 10.7        
      end      
    end

    context 'when there is 停牌' do

      let(:company_html) { File.read("#{Rails.root}/spec/request_mock/SZ000009.html") }
      let(:capital_structure_html) { File.read("#{Rails.root}/spec/request_mock/SZ000009_GBJG.html") }
      let(:capital_structure_json) { File.read("#{Rails.root}/spec/request_mock/SZ000009.json") }

      

      it "should use yesterday's price" do
        hash = subject.parse_daily_value
        expect(hash[:price]).to eq 8.48        
      end

    end
  end

end