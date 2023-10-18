class Public::PostsController < ApplicationController
  before_action :authenticate_member!, except: [:index, :show]
  before_action :ensure_correct_member, only: [:edit, :update, :destroy]
  before_action :select_published_post, only: [:show]

  def index
    # キーワード検索の時
    if params[:keyword].present?
      @posts = Post.search(params[:keyword]).published.page(params[:page])
    # タグ検索の時
    elsif params[:tag_id].present?
      @tag = Tag.find(params[:tag_id])
      @posts = @tag.posts.order(created_at: :desc).published.page(params[:page])
    # 全ての投稿一覧
    else
      @posts = Post.all.published.page(params[:page])
    end
    # 件数の順にタグを30件表示
    @favorited_tags = Tag.joins(:post_tags).group(:tag_id).order('count(post_id) desc').limit(30)
    @keyword = params[:keyword]
  end

  def show
    @post = Post.find(params[:id])
    @post_comment = PostComment.new
    @post_comments = @post.post_comments.page(params[:page]).order(created_at: :desc)
  end

  def new
    @post = Post.new
    @tag_list = @post.tags.pluck(:name).join('、')
  end

  def create
    @post = Post.new(post_params)
    @post.member_id = current_member.id
    tag_list = params[:post][:name].split("、")
    if @post.save
      @post.save_tag(tag_list)
      flash[:color] = "text-success"
      redirect_to member_path(current_member), notice: "記事を作成しました"
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
      flash[:color] = "text-success"
      redirect_to post_path(@post), notice: "記事を編集しました"
    else
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:id])
    if @post.destroy
      flash[:color] = "text-danger"
      redirect_to member_path(current_member), notice: "記事を削除しました"
    else
      redirect_to member_path(current_member), notice: "記事の削除に失敗しました"
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :tool, :body, :before_image, :after_image, :is_publish, :member_id)
  end

  # 投稿作成会員か認証
  def ensure_correct_member
    post = Post.find(params[:id])
    member = post.member
    unless member.id == current_member.id
      redirect_to member_path(current_member)
    end
  end

  # 非公開記事の閲覧制限
  def select_published_post
    post = Post.find(params[:id])
    if post.is_publish == false && post.member != current_member
      redirect_to root_path
    end
  end
end
