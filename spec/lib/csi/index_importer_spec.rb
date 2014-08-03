require 'rails_helper'

RSpec.describe Csi::IndexImporter do
  
  describe '#import_index' do

    before :each do
      load "#{Rails.root}/db/seeds/exchanges.rb"
    end
    
    it 'should be able to import CSI 300 index' do
      described_class.import_index("#{Rails.root}/db/xls/000300cons.xls", 
        { name: '沪深300', english_name: 'CSI 300 Index', code: '000300' })

      index = Index.find_by(code: '000300')
      expect(index.companies.count).to eq 300
    end

  end

end