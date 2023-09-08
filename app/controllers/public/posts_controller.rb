class Public::PostsController < ApplicationController
  def index
    @posts = Post.published
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
    if @post.save
      redirect_to member_path(current_member)
    else
      render :new
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
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
