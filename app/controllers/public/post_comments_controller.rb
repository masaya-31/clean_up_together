class Public::PostCommentsController < ApplicationController
  before_action :authenticate_member!
  before_action :ensure_correct_member, only: [:destroy]
  # コメント作成機能
  def create
    post = Post.find(params[:post_id])
    @comment = current_member.post_comments.new(post_comment_params)
    @comment.post_id = post.id
    @comment.save
  end
  # コメント削除機能
  def destroy
    @comment = PostComment.find(params[:id])
    @comment.destroy
  end

  private

  def post_comment_params
    params.require(:post_comment).permit(:comment, :member_id, :post_id)
  end
  # コメント作成した会員か認証
  def ensure_correct_member
    comment = PostComment.find(params[:id])
    member = comment.member
    unless member.id == current_member.id
      redirect_to member_path(current_member)
    end
  end
end
