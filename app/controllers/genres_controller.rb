class GenresController < ApplicationController
  def area
    controller_name =  URI(request.referer).path.split('/')[1]
    @genre = Genre.find_by(rubi:params[:genre])

    if controller_name == "districts"
      @district = District.find_by(name: params[:area])
      @shops = @district.shops.where(genre_id: @genre.id).where(status: ["無料掲載", "有料掲載", "お試し有料掲載"])
    elsif controller_name == "areas"
      @area = Area.find(params[:area])
      @district = @area.district
      @shops = @area.shops.where(genre_id: @genre.id).where(status: ["無料掲載", "有料掲載", "お試し有料掲載"])
    elsif controller_name == "prefectures"
      @prefecture = Prefecture.find_by(name: params[:area])
      @shops = @prefecture.shops.where(genre_id: @genre.id).where(status: ["無料掲載", "有料掲載", "お試し有料掲載"])
    end
  end
end
