class Public::MembersController < ApplicationController
  def show
    @member = Member.find(params[:id])
    favorites = Favorite.where(member_id: @member.id).pluck(:post_id)
    @favorite_posts = Post.find(favorites)
    @posts = @member.posts
  end

  def follows
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
end
