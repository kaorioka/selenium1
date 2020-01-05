# まず gem install selenium-webdriver してください
# 次にメルアドとパスワードを埋めてください
# あとは普通にターミナルで起動します
# 自動でブラウザが立ち上がって商品Aが５個、商品Bが６個入って思った通りになります
# 次にポイント１のコメントアウトを外すとブラウザが目に見えて立ち上がらずにコトが処理されるようになります
# でもなぜか商品Aが１０個入って、商品Bは６個入るかタイムアウトになります
# ここでポイント２のコメントアウトを外すと全てが解決します
# なぜ？？


require 'selenium-webdriver'
require 'securerandom'

#ここから４行基本設定
options = Selenium::WebDriver::Chrome::Options.new
# options.add_argument('--headless')  #ここがポイント１
d = Selenium::WebDriver.for :chrome, options: options
wait = Selenium::WebDriver::Wait.new(:timeout => 30)

#楽天にいく
d.get("https://www.rakuten.co.jp/")
#これは読み込みが終わるまで待つコード
wait.until { d.find_element(:xpath, '//*[@id="wrapper"]/div[5]/div/ul[2]/li[2]/button').displayed? }
#ログイン画面に行く
d.find_element(:xpath, '//*[@id="wrapper"]/div[5]/div/ul[2]/li[2]/button').click
#読み込み待ち
wait.until { d.find_element(:id, "loginInner_u").displayed? }
#ログイン処理
d.find_element(:id, "loginInner_u").send_keys('メルアド')
d.find_element(:id, "loginInner_p").send_keys('パスワード')
d.find_element(:class, "loginButton").click

#一つめの商品へ行く
d.get("https://item.rakuten.co.jp/kenkocom/e104166h/")
wait.until { d.find_element(:class, "rItemUnits").displayed? }
#プルダウンで５を選択
Selenium::WebDriver::Support::Select.new(d.find_element(:class, 'rItemUnits')).select_by(:value, '5')
#かごに入れる
d.find_element(:class, 'new-cart-button').click

# d.get("https://www.yahoo.co.jp/")  #ここから２行ポイント２
# wait.until { d.find_element(:class, "rapid-noclick-resp").displayed? }

#二つめの商品へ行く
d.get("https://item.rakuten.co.jp/kenkocom/20890/?s-id=kc_pc_top_slider_matome")
wait.until { d.find_element(:class, "rItemUnits").displayed? }
Selenium::WebDriver::Support::Select.new(d.find_element(:class, 'rItemUnits')).select_by(:value, '6')
d.find_element(:class, 'new-cart-button').click








# デバック用その瞬間のスクショを取れるコード
# d.save_screenshot("/Users/handaryouhei/Desktop/#{SecureRandom.hex(16)}.png")