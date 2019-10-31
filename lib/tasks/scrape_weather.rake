require 'open-uri'

namespace :scrape_weather do
  desc 'NaverまとめのTechページからタイトルを取得'
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

    # doc.xpath('//*[@id="main"]/section[4]/div/div[2]/div[1]').each do |node|
    doc.xpath('//*[@class="weather-day__day"]').each do |node|
      # タイトルの取得
      date << node.css('p').inner_text
      puts node.css('p').inner_text
      p date
    end

    got_date = []

    date.each do |d|
      tmp_date = d.scan(/(\d{1,2})/)
      got_date << (tmp_date[0] + tmp_date[1]).join('-')
      p got_date
    end
  end
end
