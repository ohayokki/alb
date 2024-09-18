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
      { name: "hokkaido"},
      { name: "aomori"},
      { name: "iwate"},
      { name: "miyagi"},
      { name: "akita"},
      { name: "yamagata"},
      { name: "fukushima"},
      { name: "tokyo"},
      { name: "kanagawa"},
      { name: "saitama"},
      { name: "chiba"},
      { name: "ibaraki"},
      { name: "tochigi"},
      { name: "gunma"},
      { name: "yamanashi"},
      { name: "niigata"},
      { name: "nagano"},
      { name: "toyama"},
      { name: "ishikawa"},
      { name: "fukui"},
      { name: "hiroshima"},
      { name: "okayama"},
      { name: "shimane"},
      { name: "tottori"},
      { name: "yamaguchi"},
      { name: "tokushima"},
      { name: "kagawa"},
      { name: "ehime"},
      { name: "kochi"},
      { name: "fukuoka"},
      { name: "saga"},
      { name: "nagasaki"},
      { name: "kumamoto"},
      { name: "oita"},
      { name: "miyazaki"},
      { name: "kagoshima"},
      { name: "okinawa"},
    ]
    prefectures.each do |prefecture|
      Prefecture.create!(prefecture)
    end
  end

  # Create districts if none exist
  if District.none?
    districts = [
      {prefecture_id: 1, name: "do-oh"},
      {prefecture_id: 1, name: "do-nan"},
      {prefecture_id: 1, name: "do-hoku"},
      {prefecture_id: 1, name: "do-toh"},
      {prefecture_id: 2, name: "aomori"},
      {prefecture_id: 2, name: "hirosaki"},
      {prefecture_id: 2, name: "hachinohe"},
      # その他の地区データも続けて追加
    ]
    districts.each do |district|
      District.create!(district)
    end
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
