module Xueqiu
  class CompanyDailyValuePopulatorForIndex

    def initialize(index)
      @index = index
    end

    def populate_for_today
      puts "Begin populate for index #{@index.name} #{Date.today}"
      i = 0
      @index.companies.each do |company|
        i += 1
        puts "Get daily value for #{company.code} #{company.name}, index: #{i}"
        daily_value = CompanyDailyValuePopulator.new(company).populate_for_today
        if daily_value
          random = rand(10)
          puts "Sleep #{random} seconds to not get blocked"
          sleep(random)
        else
          puts "The daily value for #{company.code} #{company.name} already exists, move to next"
        end
      end
    end
  end
end