class Public::HomesController < ApplicationController
  def top
    @posts = Post.all.order(created_at: :desc).limit(6)
    @tags = Tag.all
  end

  def about
  end
end
