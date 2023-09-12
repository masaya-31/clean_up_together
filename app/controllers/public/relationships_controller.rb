class Public::RelationshipsController < ApplicationController
  before_action :authenticate_member!
  # フォロー追加機能
  def create
    member = Member.find(params[:member_id])
    current_member.follow(member)
    redirect_to request.referer
  end
  # フォロー削除機能
  def destroy
    member = Member.find(params[:member_id])
    current_member.unfollow(member)
    redirect_to request.referer
  end
  # フォロー一覧表示
  def following
    @member = Member.find(params[:member_id])
    @members = @member.following
  end
end
