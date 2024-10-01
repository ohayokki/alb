class AdminShop::CommentsController < AdminShop::AdminController
  def destroy
    @comment = @shop.user_comments.find_by(id: params[:id])
    @comment.update!(status: true)
    flash[:success] = "コメントを非公開にしました。"
    redirect_back(fallback_location: root_url)
  end

  def update
    @comment = @shop.user_comments.find_by(id: params[:id])
    @comment.update!(status: false)
    flash[:success] = "コメントを公開しました。"
    redirect_back(fallback_location: root_url)
  end
end
