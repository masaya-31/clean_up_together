class Members::SessionsController < Devise::SessionsController
  def guest_sign_in
    member = Member.guest
    sign_in member
    flash[:color] = "text-success"
    redirect_to member_path(current_member), notice: 'ゲストユーザーとしてログインしました。'
  end
end