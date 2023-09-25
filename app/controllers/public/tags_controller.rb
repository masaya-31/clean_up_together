class Public::TagsController < ApplicationController
  def index
    @tags = Tag.joins(:post_tags).group(:tag_id).order('count(post_id) desc').page(params[:page]).per(30)
  end
end
