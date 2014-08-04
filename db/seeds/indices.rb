# indexes
csi_indexes = [     
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

csi_indexes.each do |index_options|
  file_path = "#{Rails.root}/db/xls/csi/#{index_options[:code]}cons.xls"
  Csi::IndexImporter.import_index(file_path, index_options)
  Rails.logger.info("Imported index " + index_options[:name])
end

cni_indexes = [
                { name: '深100', english_name: 'Shenzhen 100 Index', code: '399330' },
                { name: '中小板', english_name: 'Zhongxiao Index', code: '399005' },
                { name: '创业板', english_name: 'Chuangye Index', code: '399006' }
              ]
cni_indexes.each do |index_options|
  file_path = "#{Rails.root}/db/xls/cni/yb_#{index_options[:code]}.xls"
  Cni::IndexImporter.import_index(file_path, index_options)
  Rails.logger.info("Imported index " + index_options[:name])
end
