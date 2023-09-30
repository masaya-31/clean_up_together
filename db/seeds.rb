# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# 管理者のログイン情報の初期設定
Admin.find_or_create_by!(email: "admin@admin") do |admin|
  admin.password = "111111"
end

tarou = Member.find_or_create_by!(email: "tarou@example.com") do |member|
  member.name = "太郎"
  member.password = "tarou3"
end

katou = Member.find_or_create_by!(email: "katou@example.com") do |member|
  member.name = "加藤"
  member.password = "katou3"
end

yamada = Member.find_or_create_by!(email: "yamada@example.com") do |member|
  member.name = "山田"
  member.password = "yamada3"
end

Post.find_or_create_by!(title: "洗面ボウルの掃除") do |post|
  post.before_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-post1-1.jpg"), filename:"sample-post1-1.jpg")
  post.after_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-post1-2.jpg"), filename:"sample-post1-2.jpg")
  post.body = "使用用具：雑巾、激落くん、掃除用歯ブラシ、ポリ袋（小）
                掃除方法：
                　１：洗面ボウルを水で洗い流す。
                　２：激落くんで、全体を磨く。
                　３：水で洗い流す。
                　４：排水溝の溝に溜まった汚れを歯ブラシとポリ袋で取り除く
                　５：全体を水で洗い流す。
                　６：最後に雑巾で乾拭きし、水分を拭き取る。"
  post.member = tarou
  post.is_publish = true
end

Post.find_or_create_by!(title: "窓拭き") do |post|
  post.after_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-post2-2.jpg"), filename:"sample-post2-2.jpg")
  post.body = "
                使用用具：
                  水拭き用雑巾、乾拭き用雑巾
                掃除方法：
                　１：水拭き用雑巾を使用し、窓の左上から右上に雑巾で拭いていく。
                　２：右上まで拭いた後、雑巾一枚分下げて、次は右から左に拭いていき、コの字になるように下まで拭いていく。
                　３：全体を拭き終わったら、乾拭き用の雑巾に変えて、水拭きと同様の手順で、水を拭き取っていく。
              "
  post.member = katou
  post.is_publish = true
end

Post.find_or_create_by!(title: "エアコンのエアーフィルター掃除") do |post|
  post.after_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-post3-2.jpg"), filename:"sample-post3-2.jpg")
  post.body = "使用用具：掃除機、雑巾
                掃除方法：
                　１：フィルターを開ける。
                　２：ロックを外す。
                　３：フィルターの押さえを上げながら、エアーフィルターを取り出す。
                　４：取り出したエアーフィルターの汚れを掃除機で吸い取る。
                　５：掃除機で落ちない汚れを水で濡らした雑巾で拭き取る。
                　６：エアーフィルターを陰干しする
                　７：エアーフィルターが乾いたら、取り外しと逆の手順で取り付ける。
              "
  post.member = yamada
  post.is_publish = true
end