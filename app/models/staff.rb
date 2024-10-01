class Staff < ApplicationRecord
  belongs_to :shop
  mount_uploader :image, StaffUploader

  #validates :image, content_type: { in: %w[image/jpeg image/png image/gif], message: "must be a valid image format" }, size: { less_than: 5.megabytes, message: "should be less than 5MB" }# 画像はJPEG, PNG, GIF形式かつ5MB以下

  validates :name, presence: true, length: { maximum: 50 }  # 名前は必須で50文字以内
  #validates :blood_type, presence: true, inclusion: { in: %w[A B AB O], message: "%{value} is not a valid blood type" } # 血液型は必須でA, B, AB, O のいずれか
  # validates :birthday, optional: true
  
  validates :height, numericality: { only_integer: true, greater_than: 50, less_than: 250 }, allow_nil: true # 身長は数値で50cmから250cmの範囲
  # validates :alcohol, presence: true, inclusion: { in: %w[強い 普通 弱い 飲めない], message: "%{value} is not a valid alcohol preference" } # アルコールの得意度は指定された値
  validates :message, length: { maximum: 500 }, allow_blank: true # メッセージは任意だが、500文字以内
  validates :hobby, length: { maximum: 100 }, allow_blank: true # 趣味は100文字以内
  validates :role, presence: true, length: { maximum: 30 }  # 役職は必須で30文字以内
  validates :service_style, presence: true, length: { maximum: 50 } # 接客スタイルは必須で50文字以内
  validates :qualifications, length: { maximum: 100 }, allow_blank: true # 資格は任意で100文字以内


end
