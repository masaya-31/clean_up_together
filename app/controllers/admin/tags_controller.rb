class Admin::TagsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @tags = Tag.joins(:post_tags).group(:tag_id).order('count(post_id) desc').page(params[:page]).per(30)
  end

  def destroy
    tag = Tag.find(params[:id])
    tag.destroy
    redirect_to admin_tags_path
  end
end
