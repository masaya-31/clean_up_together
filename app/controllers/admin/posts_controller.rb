class Admin::PostsController < ApplicationController
  before_action :authenticate_admin!

  def index
    # タグ検索の時
    if params[:tag_id].present?
      @tag = Tag.find(params[:tag_id])
      @posts = @tag.posts.order(created_at: :desc).page(params[:page])
    else
      # 投稿一覧表示
      @posts = Post.all.order(created_at: :desc).page(params[:page])
    end
    # 件数の多い順にタグを30件表示
    @favorited_tags = Tag.joins(:post_tags).group(:tag_id).order('count(post_id) desc').limit(30)
  end

  def show
    @post = Post.find(params[:id])
    @post_comments = @post.post_comments.page(params[:page]).order(created_at: :desc)
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to admin_posts_path
  end
end
