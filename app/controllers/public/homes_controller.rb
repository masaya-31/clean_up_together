class Public::HomesController < ApplicationController
  def top
    @posts = Post.all
    @tags = Tag.all
  end

  def about
  end
end
