class Admin::MembersController < ApplicationController
  def index
    @members = Member.all
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
    @posts = @member.posts
  end

  private

  def member_params
    params.require(:member).permit(:name, :introduction, :email, :is_active)
  end
end
