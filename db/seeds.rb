# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

require_relative 'seeds/prefecture'
require_relative 'seeds/district'
require_relative 'seeds/genre'
require_relative 'seeds/tag'

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
  Area.find_or_create_by!(area)
end
