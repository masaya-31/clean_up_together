class Public::MembersController < ApplicationController
  def show
    @member = Member.find(params[:id])
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
  end

  def email_update

  end

  def password_edit
  end

  def password_update

  end

  private

  def member_profile_params
    params.require(:member).permit(:name, :introduction)
  end
end
