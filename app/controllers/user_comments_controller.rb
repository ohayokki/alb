class UserCommentsController < ApplicationController

  def create
    return redirect_to root_url unless user_signed_in?
    @comment = current_user.user_comments.build(comment_params)
    if @comment.save
      flash[:success] = "コメントありがとうございます。投稿しました。"
      redirect_to shops_url(@comment.shop_id)
    else
      @shop = Shop.find_by(id: params[:user_comment][:shop_id])
      flash[:danger] = "コメント投稿に失敗しました。"
      redirect_to shop_url @shop, status: :unprocessable_entity
    end
  end

  def update
    @comment = current_user.user_comments.find_by(id: params[:id])
    @comment.update!(status: false)
    flash[:success] = "コメントを公開しました。"
    redirect_back(fallback_location: root_url)
  end

  def destroy
    @comment = current_user.user_comments.find_by(id: params[:id])
    @comment.update!(status: true)
    flash[:success] = "コメントを非公開にしました。"
    redirect_back(fallback_location: root_url)
  end

  private
  def comment_params
    params.require(:user_comment).permit(:comment, :score, :shop_id)
  end
end
