require 'open-uri'
require 'JSON'

module Xueqiu

  class CompanyParser
    BASE_URL = 'http://xueqiu.com'

    def initialize(company)
      @company = company
    end

    # It returns a daily value
    def parse_daily_value
      doc = Nokogiri::HTML(open(company_url))
      price = price_from(doc)
      pe_ttm = pe_ttm_from(doc)
      pb = pb_from(doc)

      response = RestClient.get(capital_structure_url)
      json = RestClient.get(capital_structure_json_url, cookies: response.cookies)
      json = JSON.parse(json)

      total_shares = total_shares(json)
      circulating_shares = circulating_shares(json)

      { 
        date: Date.today,
        total_shares: total_shares,
        circulating_shares: circulating_shares,
        price: price,
        pe_ttm: pe_ttm,
        pb: pb
      }
    end

    private

    def company_url
      "#{BASE_URL}/S/#{@company.exchange.abbreviation}#{@company.code}"
    end

    def price_from(doc)
      doc.xpath("//div[@id='currentQuote']").first.
        xpath(".//strong").first.attr('data-current').
        strip.to_f
    end

    def pe_ttm_from(doc)
      pe_value = doc.xpath("//td[contains(text(),'市盈率')]").first.
                      xpath('.//span').first.text
      pe_value.split('/')[1].strip.to_f
    end

    def pb_from(doc)
      pb_value = doc.xpath("//td[contains(text(),'市净率')]").first.
                      xpath('.//span').first.text
      pb_value.strip.to_f
    end

    def capital_structure_url
      "#{company_url}/GBJG"
    end

    def capital_structure_json_url
      time = DateTime.now.to_i * 1000
      "#{BASE_URL}/stock/f10/shareschg.json?symbol=#{@company.exchange.abbreviation}#{@company.code}&page=1&size=4&_=#{time.to_s}"
    end

    def total_shares(json)
      (json['list'].first['totalshare'].to_f * 10000).to_i
    end

    def circulating_shares(json)
      (json['list'].first['circskamt'].to_f * 10000).to_i
    end
  end
end