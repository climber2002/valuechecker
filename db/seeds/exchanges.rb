exchanges = [
              { name: "上交所", abbreviation: "SH", english_name: "Shanghai" },
              { name: "深交所", abbreviation: "SZ", english_name: "Shenzhen" }
            ]

exchanges.each do |exchange_options|
  unless Exchange.find_by(abbreviation: exchange_options[:abbreviation])
    Exchange.create!(exchange_options)
  end
end