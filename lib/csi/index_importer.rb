require 'pathname'

# Csi stands for China Securities Index
# 中证
module Csi

  class IndexImporter

    # Import the consitituent file downloaded from CSI website http://www.csindex.com.cn/
    # the file is an Excel xls file, the filename format is #{code}cons.xls, the content is like:
    # "成分券代码 Constituent Code" "成分券名称 Constituent Name" "成分券英文名称 Constituent Name(Eng.)" "交易所 Exchange"
    # 000009  中国宝安  China Baoan Group Co.,Ltd.  Shenzhen
    # 000012  南  玻Ａ CSG Holding Co Ltd  Shenzhen
    def self.import_index(file_path, index_options={})
      index_options[:code] ||= extract_index_code_from_filename(file_path)

      index = Index.find_by(code: index_options[:code])
      unless index
        index = Index.create!(index_options)
      end

      excel = Roo::Excel::new(file_path)

      2.upto(excel.last_row) do |row|
        company_code = excel.cell(row, 1).to_s.strip
        company_name = excel.cell(row, 2).to_s.strip
        company_english_name = excel.cell(row, 3).to_s.strip
        exchange_english_name = excel.cell(row, 4).to_s.strip

        company = Company.find_by(code: company_code)
        unless company
          company = Company.create!(code: company_code, name: company_name,
            english_name: company_english_name, exchange_english_name: exchange_english_name)
        end

        unless index.company_by_code(company_code)
          index.index_items.create!(company: company)
        end
      end
    end

    private

    # the index code is the first numbers of the filename, e.g. if the filename
    # is 000300cons.xls then the code is 000300
    def self.extract_index_code_from_filename(file_path)
      Pathname.new(file_path).basename[/\A\d*/, 0]
    end
  end

end