class IndexDailyGenerator

  def initialize(index)
    @index = index
  end

  def generate_for_today
    today = Date.today

    return false if @index.index_daily_on(today)

    attrs = { date: today, market_value: 0.0, earnings_ttm: 0.0, books: 0.0 }
    @index.companies.each do |company|
      daily_value = company.daily_value_on(today)
      unless daily_value
        populator = Xueqiu::CompanyDailyValuePopulator.new(company)
        daily_value = populator.populate_for_today
      end

      
      [:market_value, :earnings_ttm, :books].each do |metric|
        attrs[metric] += daily_value.public_send(metric)
      end
    end

    index_daily = @index.index_dailies.build(attrs)
    index_daily.save
    index_daily
  end

end