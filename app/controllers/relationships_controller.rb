class RelationshipsController < ApplicationController

  def create
    @relathionship = current_user.relationships.build(relationship_params)
    @relathionship.save!
    flash[:success] = "フォローしました。"
    redirect_back(fallback_location: root_url)
  end

  def destroy
    @relathionship = current_user.relationships.find_by(id: params[:id])
    @relathionship.destroy
    flash[:success] = "フォロー解除しました。"
    redirect_back(fallback_location: root_url)
  end

  private
  def relationship_params
    params.require(:relationship).permit(:shop_id)
  end
end
