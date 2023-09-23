class Admin::PostsController < ApplicationController
  before_action :authenticate_admin!

  def index
    # キーワード検索の時
    if params[:keyword].present?
      @posts = Post.search(params[:keyword]).published
    # タグ検索の時
    elsif params[:tag_id].present?
      @tag = Tag.find(params[:tag_id])
      @posts = @tag.posts.order(created_at: :desc).published
    # 全ての投稿一覧
    else
      @posts = Post.all.order(created_at: :desc).published
    end
    @tags = Tag.all
    # 投稿件数
    @all_posts_count = @posts.count
    @keyword = params[:keyword]
  end

  def show
    @post = Post.find(params[:id])
  end
end
