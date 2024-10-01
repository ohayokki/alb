class User < ApplicationRecord
  has_many :user_comments
  has_many :relationships
  has_many :shops, through: :relationships
  
  def followings?(shop)
    self.shops.include?(shop)
  end
end
