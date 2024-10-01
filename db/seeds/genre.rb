genres = [
  {name: "cafe", description: "静かな時間を過ごせる、心癒されるカフェ"}, #(A quiet space to relax and unwind)
  {name: "casual-bar", description: "気軽に入りやすいバー"}, # (Craft cocktails for a special night)
  {name: "cocktail-bar", description: "華やかなカクテルで特別な夜を演出"}, # (Craft cocktails for a special night)
  {name: "wine-bar", description: "選び抜かれたワインをじっくり堪能する空間"}, # (Enjoy carefully selected wines in style)
  {name: "authentic-bar", description: "本格派カクテルと上質な時間を楽しむ高級バー"}, # (Experience quality in a true authentic bar)
  {name: "shisha-bar", description: "異国の香り漂うシーシャでリラックス"}, # (Relax with exotic shisha flavors)
  {name: "karaoke-bar", description: "歌って飲んでストレス発散、楽しさ満点！"} , # (Sing your heart out with a drink in hand!)
  {name: "darts-bar", description: "ダーツとお酒で盛り上がる大人の遊び場"}, # (Fun and games with darts and drinks)
  {name: "pool-bar", description: "ビリヤードと共にお酒を楽しむ社交の場"}, # (Enjoy pool and drinks in a social setting)
  {name: "dining-bar", description: "美味しい食事とお酒が同時に楽しめる贅沢空間"}, # (Indulge in fine food and drinks together)
  {name: "sports-bar", description: "大画面で観戦しながら仲間と盛り上がれるバー"}, # (Cheer on your team with friends in a bar)
  {name: "club", description: "音楽とダンスで夜を楽しむエンタメバー"}, # (Dance and party the night away)
  {name: "concept-cafe", description: "個性的なテーマで非日常を楽しめるカフェ"}, # (Unique themes for a special cafe experience)
  {name: "concept-bar", description: "独自の世界観でお酒を楽しむ特別なバー"}, # (Explore distinct vibes and drinks)
  {name: "snack-pub", description: "気軽に立ち寄れる、アットホームな雰囲気"}, # (Casual, homey atmosphere for a quick drink)
  {name: "girls-bar", description: "楽しい会話とお酒を楽しめる女性接客のバー"}, # (Friendly female staff and drinks to enjoy)
  {name: "mens-pub", description: "男性スタッフとの楽しいひとときを過ごせるパブ"} # (Enjoy a fun time with male staff)
]

genres.each do |genre|
  Genre.find_or_create_by!(genre)
end

puts "ジャンルを登録しました！"
