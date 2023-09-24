class Public::MembersController < ApplicationController
  before_action :authenticate_member!
  before_action :ensure_normal_user, only: [:update, :email_update]

  def show
    @member = Member.find(params[:id])
    @posts = @member.posts.published.page(params[:page])
  end

  def unpublish
    @member = current_member
    @posts = @member.posts.unpublished.page(params[:page])
  end

  def favorite
    @member = Member.find(params[:member_id])
    @posts = @member.favorited_posts.includes(:member).published.page(params[:page])
  end

  def edit
    @member = current_member
  end

  def update
    @member = current_member
    if @member.update(member_profile_params)
      redirect_back(fallback_location: root_path)
    else
      render :edit
    end
  end

  def login_edit
    @member = current_member
  end

  def email_edit
    @member = current_member
  end

  def email_update
    @member = current_member
    if @member.update(member_email_params)
      redirect_to login_edit_members_path
    else
      render :email_edit
    end
  end

  private

  def member_profile_params
    params.require(:member).permit(:name, :introduction)
  end

  def member_email_params
    params.require(:member).permit(:email)
  end

  def ensure_normal_user
    if current_member.email == 'guest@example.com'
      redirect_to edit_member_path(member), notice: 'ゲストユーザーの情報は編集できません。'
    end
  end

end
