# http://www.cnindex.com.cn/ 巨潮
module Cni

  class IndexImporter

    def self.import_index(file_path, index_options={})
      
      index = Index.find_by(code: index_options[:code])
      unless index
        index = Index.create!(index_options)
      end

      excel = Roo::Excel::new(file_path)

      2.upto(excel.last_row) do |row|
        company_code = excel.cell(row, 3).to_s.strip
        company_name = excel.cell(row, 4).to_s.strip
        exchange_english_name = 'Shenzhen'

        company = Company.find_by(code: company_code)
        unless company
          company = Company.create!(code: company_code, name: company_name,
            exchange_english_name: exchange_english_name)
        end

        unless index.company_by_code(company_code)
          index.index_items.create!(company: company)
        end
      end
    end

  end
end