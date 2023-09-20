class Public::MembersController < ApplicationController
  before_action :authenticate_member!
  before_action :ensure_correct_member, except: [:show, :favorite, :unpublish]
  before_action :ensure_normal_user, only: [:update, :email_update]

  def show
    @member = Member.find(params[:id])
    favorites = Favorite.where(member_id: @member.id).pluck(:post_id)
    @favorite_posts = Post.find(favorites)
    @posts = @member.posts.published
  end

  def favorite
    @member = Member.find(params[:member_id])
    @favorites = Favorite.where(member_id: @member.id).pluck(:post_id)
    @favorite_posts = Post.find(@favorites)
  end

  def unpublish
    @member = current_member
    @unpublish_posts = @member.posts.unpublished
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

  def email_edit
    @member = current_member
  end

  def email_update
    @member = current_member
    if @member.update(member_email_params)
      redirect_to edit_member_path(@member)
    else
      render :email_edit
    end
  end

  # def password_edit
  # end

  # def password_update

  # end

  private

  def member_profile_params
    params.require(:member).permit(:name, :introduction)
  end

  def member_email_params
    params.require(:member).permit(:email)
  end

  def ensure_correct_member
    member = Member.find(params[:id])
    unless member.id == current_member.id
      redirect_to member_path(current_member)
    end
  end

  def ensure_normal_user
    member = Member.find(params[:id])
    if member.email == 'guest@example.com'
      redirect_to edit_member_path(member), notice: 'ゲストユーザーの情報は編集できません。'
    end
  end

end
