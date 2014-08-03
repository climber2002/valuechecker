require 'rails_helper'

RSpec.describe Cni::IndexImporter do
  
  describe '#import_index' do

    before :each do
      load "#{Rails.root}/db/seeds/exchanges.rb"
    end
    
    it 'should be able to import CSI 300 index' do
      described_class.import_index("#{Rails.root}/db/xls/cni/yb_399005.xls", 
        { name: '中小板', english_name: 'Zhongxiao Index', code: '399005' })

      index = Index.find_by(code: '399005')
      expect(index.companies.count).to eq 100
    end

  end

end