class Admin::PostsController < ApplicationController
  before_action :authenticate_admin!

  def index
    # タグ検索の時
    if params[:tag_id].present?
      @tag = Tag.find(params[:tag_id])
      @posts = @tag.posts.order(created_at: :desc).page(params[:page])
    # 全ての投稿一覧
    else
      @posts = Post.all.order(created_at: :desc).page(params[:page])
    end
    @tags = Tag.all.limit(30)
    @favorited_tags = Tag.joins(:post_tags).group(:tag_id).order('count(post_id) desc')
  end

  def show
    @post = Post.find(params[:id])
    @post_comments = @post.post_comments.page(params[:page])
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to admin_posts_path
  end
end
