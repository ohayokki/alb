# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

  # Create prefectures if none exist
  if Prefecture.none?
    prefectures = [
      { id: 1, name: "hokkaido"},
      { id: 2, name: "aomori"},
      { id: 3, name: "iwate"},
      { id: 4, name: "miyagi"},
      { id: 5, name: "akita"},
      { id: 6, name: "yamagata"},
      { id: 7, name: "fukushima"},
      { id: 8, name: "ibaraki"},
      { id: 9, name: "tochigi"},
      { id: 10, name: "gunma"},
      { id: 11, name: "saitama"},
      { id: 12, name: "chiba"},
      { id: 13, name: "tokyo"},
      { id: 14, name: "kanagawa"},
      { id: 15, name: "niigata"},
      { id: 16, name: "toyama"},
      { id: 17, name: "ishikawa"},
      { id: 18, name: "fukui"},
      { id: 19, name: "yamanashi"},
      { id: 20, name: "nagano"},
      { id: 21, name: "gifu"},
      { id: 22, name: "shizuoka"},
      { id: 23, name: "aichi"},
      { id: 24, name: "mie"},
      { id: 25, name: "shiga"},
      { id: 26, name: "kyoto"},
      { id: 27, name: "osaka"},
      { id: 28, name: "hyogo"},
      { id: 29, name: "nara"},
      { id: 30, name: "wakayama"},
      { id: 31, name: "tottori"},
      { id: 32, name: "shimane"},
      { id: 33, name: "okayama"},
      { id: 34, name: "hiroshima"},
      { id: 35, name: "yamaguchi"},
      { id: 36, name: "tokushima"},
      { id: 37, name: "kagawa"},
      { id: 38, name: "ehime"},
      { id: 39, name: "kochi"},
      { id: 40, name: "fukuoka"},
      { id: 41, name: "saga"},
      { id: 42, name: "nagasaki"},
      { id: 43, name: "kumamoto"},
      { id: 44, name: "oita"},
      { id: 45, name: "miyazaki"},
      { id: 46, name: "kagoshima"},
      { id: 47, name: "okinawa"}
    ]
    
    prefectures.each do |prefecture|
      Prefecture.create!(prefecture)
    end
  end

  # Create districts if none exist
  districts = [
    {prefecture_id: 1, name: "do-oh"},
    {prefecture_id: 1, name: "do-nan"},
    {prefecture_id: 1, name: "do-hoku"},
    {prefecture_id: 1, name: "do-toh"},
    {prefecture_id: 2, name: "aomori"},
    {prefecture_id: 2, name: "hirosaki"},
    {prefecture_id: 2, name: "hachinohe"},
    {prefecture_id: 3, name: "iwate"},
    {prefecture_id: 3, name: "morioka"},
    {prefecture_id: 4, name: "miyagi"},
    {prefecture_id: 4, name: "sendai"},
    {prefecture_id: 5, name: "akita"},
    {prefecture_id: 6, name: "yamagata"},
    {prefecture_id: 7, name: "fukushima"},
    {prefecture_id: 8, name: "chuo"},
    {prefecture_id: 8, name: "minato"},
    {prefecture_id: 8, name: "chiyoda"},
    {prefecture_id: 8, name: "koto"},
    {prefecture_id: 8, name: "shinagawa"},
    {prefecture_id: 8, name: "edogawa"},
    {prefecture_id: 8, name: "katsushika"},
    {prefecture_id: 8, name: "sumida"},
    {prefecture_id: 8, name: "ota"},
    {prefecture_id: 8, name: "meguro"},
    {prefecture_id: 8, name: "setagaya"},
    {prefecture_id: 8, name: "shibuya"},
    {prefecture_id: 8, name: "shinjyuku"},
    {prefecture_id: 8, name: "nakano"},
    {prefecture_id: 8, name: "suginami"},
    {prefecture_id: 8, name: "toshima"},
    {prefecture_id: 8, name: "kita"},
    {prefecture_id: 8, name: "nerima"},
    {prefecture_id: 8, name: "bunkyo"},
    {prefecture_id: 8, name: "arakawa"},
    {prefecture_id: 8, name: "taito"},
    {prefecture_id: 8, name: "itabashi"},
    {prefecture_id: 8, name: "adachi"},
    {prefecture_id: 8, name: "kitatama"},
    {prefecture_id: 8, name: "minamitama"},
    {prefecture_id: 8, name: "nishitama"},
    {prefecture_id: 8, name: "izuogasawara"},

  ]
  districts.each do |district|
    District.find_or_create_by!(district)
  end

  if Area.none?
    areas = [
      {prefecture_id: 1, district_id: 1, name: "札幌・すすきの" }, 
      {prefecture_id: 1, district_id: 1, name: "札幌駅" },
      {prefecture_id: 1, district_id: 1, name: "大通・狸小路" },
      {prefecture_id: 1, district_id: 1, name: "札幌市中央区" },
      {prefecture_id: 1, district_id: 1, name: "札幌市西区" },
      {prefecture_id: 1, district_id: 1, name: "札幌市手稲区" },
      {prefecture_id: 1, district_id: 1, name: "札幌市北区" },
      {prefecture_id: 1, district_id: 1, name: "札幌市白石区" },
      {prefecture_id: 1, district_id: 1, name: "札幌市厚別区" },
      {prefecture_id: 1, district_id: 1, name: "札幌市豊平区" },
      {prefecture_id: 1, district_id: 1, name: "札幌市南区" },
      {prefecture_id: 1, district_id: 1, name: "小樽市" }
    ]
    areas.each do |area|
      Area.create!(area)
    end
  end

  if Genre.none?
    genres = [
      {name: "カフェ", rubi: "cafe", description: "静かな時間を過ごせる、心癒されるカフェ"}, #(A quiet space to relax and unwind)
      {name: "カジュアルバー", rubi: "casual-bar", description: "気軽に入りやすいバー"}, # (Craft cocktails for a special night)
      {name: "カクテルバー", rubi: "cocktail-bar", description: "華やかなカクテルで特別な夜を演出"}, # (Craft cocktails for a special night)
      {name: "ワインバー", rubi: "wine-bar", description: "選び抜かれたワインをじっくり堪能する空間"}, # (Enjoy carefully selected wines in style)
      {name: "オーセンティックバー", rubi: "authentic-bar", description: "本格派カクテルと上質な時間を楽しむ高級バー"}, # (Experience quality in a true authentic bar)
      {name: "シーシャバー", rubi: "shisha-bar", description: "異国の香り漂うシーシャでリラックス"}, # (Relax with exotic shisha flavors)
      {name: "カラオケバー", rubi: "karaoke-bar", description: "歌って飲んでストレス発散、楽しさ満点！"} , # (Sing your heart out with a drink in hand!)
      {name: "ダーツバー", rubi: "darts-bar", description: "ダーツとお酒で盛り上がる大人の遊び場"}, # (Fun and games with darts and drinks)
      {name: "プールバー", rubi: "pool-bar", description: "ビリヤードと共にお酒を楽しむ社交の場"}, # (Enjoy pool and drinks in a social setting)
      {name: "ダイニングバー", rubi: "dining-bar", description: "美味しい食事とお酒が同時に楽しめる贅沢空間"}, # (Indulge in fine food and drinks together)
      {name: "スポーツバー", rubi: "sports-bar", description: "大画面で観戦しながら仲間と盛り上がれるバー"}, # (Cheer on your team with friends in a bar)
      {name: "クラブ", rubi: "club", description: "音楽とダンスで夜を楽しむエンタメバー"}, # (Dance and party the night away)
      {name: "コンセプトカフェ", rubi: "concept-cafe", description: "個性的なテーマで非日常を楽しめるカフェ"}, # (Unique themes for a special cafe experience)
      {name: "コンセプトバー", rubi: "concept-bar", description: "独自の世界観でお酒を楽しむ特別なバー"}, # (Explore distinct vibes and drinks)
      {name: "スナック・パブ", rubi: "snack-pub", description: "気軽に立ち寄れる、アットホームな雰囲気"}, # (Casual, homey atmosphere for a quick drink)
      {name: "ガールズバー", rubi: "girls-bar", description: "楽しい会話とお酒を楽しめる女性接客のバー"}, # (Friendly female staff and drinks to enjoy)
      {name: "メンパブ", rubi: "mens-pub", description: "男性スタッフとの楽しいひとときを過ごせるパブ"} # (Enjoy a fun time with male staff)
    ]
   
    genres.each do |genre|
      Genre.create!(genre)
    end
  end

# 事前に50個のタグを登録する
tags = [
  "おしゃれ", "隠れ家", "アットホーム", "個室あり", "カラオケあり", "ダーツあり", "バー", 
  "コンカフェ", "ガールズバー", "ラウンジ", "シャンパンタワー", "お通しなし", "深夜営業", 
  "昼間営業", "クラシック", "ジャズ", "ロック", "ポップ", "ワインバー", "ウイスキー", 
  "カクテル豊富", "ビール", "日本酒", "焼酎", "リキュール", "フルーツカクテル", "ノンアルコール", 
  "手作り料理", "つまみ", "グリル", "ビストロ", "テキーラ", "ラム酒", "サプライズ対応", 
  "生演奏", "DJ", "ライブ", "スポーツ観戦", "大画面テレビ", "外国語メニュー", "英語対応", 
  "カップルシート", "女子会", "デート向き", "友達同士", "一人で気軽に", "貸し切り可", 
  "イベント開催", "ドレスコードあり", "喫煙可", "禁煙"
]

tags.each do |tag_name|
  Label.find_or_create_by(name: tag_name)
end

puts "#{tags.size}個のタグを登録しました！"
