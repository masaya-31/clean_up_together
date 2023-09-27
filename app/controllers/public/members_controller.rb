class Public::MembersController < ApplicationController
  before_action :authenticate_member!
  before_action :ensure_normal_user, only: [:update, :email_update]

  def show
    @member = Member.find(params[:id])
    @posts = @member.posts.published.page(params[:page]).order(created_at: :desc)
  end

  def unpublish
    @member = current_member
    @posts = @member.posts.unpublished.page(params[:page]).order(created_at: :desc)
  end

  def favorite
    @member = Member.find(params[:id])
    @posts = @member.favorited_posts.includes(:member).published.page(params[:page]).order(created_at: :desc)
  end

  def edit
    @member = current_member
  end

  def update
    @member = current_member
    if @member.update(member_profile_params)
      redirect_to request.referer, notice: 'プロフィール情報を変更しました'
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
      redirect_to login_edit_members_path, notice: 'アカウント情報を変更しました'
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
      flash[:color] = "text-danger"
      redirect_to member_path(current_member), notice: 'ゲストユーザーの情報は編集できません。'
    end
  end

end
