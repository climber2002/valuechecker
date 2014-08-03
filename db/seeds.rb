# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

exchanges = [
              { name: "上交所", abbreviation: "SH", english_name: "Shanghai" },
              { name: "深交所", abbreviation: "SZ", english_name: "Shenzhen" }
            ]

exchanges.each do |exchange_options|
  unless Exchange.find_by(abbreviation: exchange_options[:abbreviation])
    Exchange.create!(exchange_options)
  end
end

# indexes
indexes = [     
                # 中证
                { name: '沪深300', english_name: 'CSI 300 Index', code: '000300' },
                { name: '中证100', english_name: 'CSI 100 Index', code: '000903' },
                { name: '中证200', english_name: 'CSI 200 Index', code: '000904' },
                { name: '中证500', english_name: 'CSI 500 Index', code: '000905' },
                # 上证
                { name: '上证50', english_name: 'Shanghai 50 Index', code: '000016' },
                { name: '上证180', english_name: 'Shanghai 180 Index', code: '000010' },
                { name: '上证380', english_name: 'Shanghai 380 Index', code: '000009' }

              ]

indexes.each do |index_options|
  file_path = "#{Rails.root}/db/xls/#{index_options[:code]}cons.xls"
  Csi::IndexImporter.import_index(file_path, index_options)
  Rails.logger.info("Imported index " + index_options[:name])
end

