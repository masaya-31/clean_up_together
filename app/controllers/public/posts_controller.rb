class Public::PostsController < ApplicationController
  before_action :authenticate_member!, except: [:index, :show]
  before_action :ensure_correct_member, only: [:edit, :update, :destroy]

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
    @post_comment = PostComment.new
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.member_id = current_member.id
    tag_list = params[:post][:name].split("、")
    if @post.save
      @post.save_tag(tag_list)
      redirect_to member_path(current_member)
    else
      render :new
    end
  end

  def edit
    @post = Post.find(params[:id])
    @tag_list = @post.tags.pluck(:name).join('、')
  end

  def update
    @post = Post.find(params[:id])
    tag_list = params[:post][:name].split('、')
    if @post.update(post_params)
      @post.save_tag(tag_list)
      redirect_to post_path(@post)
    else
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to member_path(current_member)
  end

  private

  def post_params
    params.require(:post).permit(:title, :body, :before_image, :after_image, :is_publish, :member_id)
  end
  # 投稿作成会員か認証
  def ensure_correct_member
    post = Post.find(params[:id])
    member = post.member
    unless member.id == current_member.id
      redirect_to member_path(current_member)
    end
  end
end
