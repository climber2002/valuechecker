module Xueqiu

  class CompanyDailyValuePopulator

    def initialize(company)
      @company = company
    end

    def populate_for_today
      today = Date.today
      daily_value = @company.daily_value_on(today)
      return false if daily_value # already exist, don't populate again
      
      daily_value = @company.daily_values.build(CompanyParser.new(@company).parse_daily_value)
      daily_value.save 
      daily_value
    end
  end

end