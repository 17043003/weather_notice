require 'open-uri'
require 'date'

namespace :scrape_weather do
  desc '天気の情報を取得'
  task :weather_date => :environment do
    # スクレイピング先のURL
    url = 'https://weathernews.jp/onebox/tenki/chiba/12212/'

    charset = nil
    html = open(url) do |f|
      charset = f.charset # 文字種別を取得
      f.read # htmlを読み込んで変数htmlに渡す
    end

    # htmlをパース(解析)してオブジェクトを作成
    doc = Nokogiri::HTML.parse(html, nil, charset)
    date = []
    now_year = Date.current.year.to_s

    doc.xpath('//*[@class="weather-day__day"]').each do |node|
      # タイトルの取得
      date << node.css('p').inner_text
    end

    weather = ""
    got_date = []
    place = ""

    date.each do |d|
      tmp_date = d.scan(/(\d{1,2})/)
      got_date << (tmp_date[0] + tmp_date[1]).join('-')
    end
    # 今日の日付だけ取る
    got_date[0] = now_year + "-" + got_date[0]
    p got_date

    doc.xpath('//*[@class="index__tit"]').each do |node|
      # 場所の取得
      place = node.inner_text
      pos = place.index('の')
      place = place[0..pos-1]
      p place
    end

    doc.xpath('//*[@class="weather-now__ul"]/li[1]').each do |node|
      # 今日の天気を取得
      weather = node.css('text()').inner_text[2..3]
      p weather
    end

    doc.xpath('//*[@class="weather-now__ul"]/li[2]').each do |node|
      # 今日の気温の取得
      temperature = node.css('text()').inner_text[2..-1]
      p temperature
    end

    weather_info = Weather.new(weather: weather, date: got_date[0], place: place)
    weather_info.save

  end
end
