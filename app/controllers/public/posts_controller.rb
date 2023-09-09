class Public::PostsController < ApplicationController
  def index
    if params[:search].present?
      @posts = Post.posts_serach(params[:search])
    elsif params[:tag_id].present?
      @tag = Tag.find(params[:tag_id])
      @posts = @tag.posts.order(created_at: :desc)
    else
      @posts = Post.all.order(created_at: :desc)
    end
    @tags = Tag.all
    @all_posts_count = @posts.count
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

end
