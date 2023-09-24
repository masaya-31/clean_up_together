class Admin::MembersController < ApplicationController
  before_action :authenticate_admin!

  def index
    @members = Member.page(params[:page])
  end

  def edit
    @member = Member.find(params[:id])
  end

  def update
    member = Member.find(params[:id])
    member.update(member_params)
    redirect_to admin_members_path
  end

  def posts
    @member = Member.find(params[:id])
    @posts = @member.posts.page(params[:page])
    @tags = Tag.all.limit(30)
    @favorited_tags = Tag.joins(:post_tags).group(:tag_id).order('count(post_id) desc')
  end

  def post_comments
    @member = Member.find(params[:id])
    @comments = @member.post_comments.page(params[:page])
  end

  private

  def member_params
    params.require(:member).permit(:name, :introduction, :email, :is_active)
  end
end
