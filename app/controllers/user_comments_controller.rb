class UserCommentsController < ApplicationController

  def create
    return redirect_to root_url unless user_signed_in?
    @comment = current_user.user_comments.build(comment_params)
    if @comment.save!
      flash[:success] = "コメントありがとうございます。投稿しました。"
      redirect_to shops_url(@comment.shop_id)
    else
      flash.now[:danger] = "コメント投稿に失敗しました。"
      
     render "shops/show", status: unprocessable_entity
    end
  end

  def destroy
    @comment = current_user.user_comments.find_by(id: params[:id])
    shop = @comment.shop
    @comment.destroy
    flash[:success] = "コメントを削除しました。"
    redirect_to shops_url(shop)
  end
  private
  def comment_params
    params.require(:user_comment).permit(:comment, :shop_id)
  end
end
