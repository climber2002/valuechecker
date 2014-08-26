namespace :index do
  desc "Populate the company and index data for today"
  task populate_for_today: :environment do
    tries = 10
    begin
      Index.all.each do |index|
        Xueqiu::CompanyDailyValuePopulatorForIndex.new(index).populate_for_today
      end

      Index.all.each do |index|
        IndexDailyGenerator.new(index).generate_for_today
      end  
    rescue Exception => e
      tries -= 1
      if tries > 0
        retry
      else
        Rails.logger.error("error when populate, #{e}")
      end
    end
    
  end

  desc "Print the PE and PB for all indexes"
  task print_for_latest: :environment do
    today = Date.today
    puts "今天: #{today}"
    Index.all.each do |index|
      latest_daily = index.latest_index_daily
      puts "#{index.name}\t\tPE(TTM):#{latest_daily.pe_ttm.to_f.round(2)}\t\t\tPB:#{latest_daily.pb.to_f.round(2)}"
    end
  end
end
