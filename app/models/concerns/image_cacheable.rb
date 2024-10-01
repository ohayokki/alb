module ImageCacheable
  extend ActiveSupport::Concern

  included do
    attr_accessor :image_cache
  end

  def assign_cache_image(image_field)
    if send("#{image_field}_cache").present?
      send("#{image_field}=", send("#{image_field}_cache"))
    end
  end
end
