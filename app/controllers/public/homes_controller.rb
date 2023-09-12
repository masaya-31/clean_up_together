class Public::HomesController < ApplicationController
  
  def top
    @posts = Post.all.order(created_at: :desc).limit(6)
    # いいね数順に並べ替え
    @favorited_posts = Post.includes(:favorited_members).limit(6).sort {|a,b| b.favorited_members.size <=> a.favorited_members.size}
    @tags = Tag.all
  end

  def about
  end
end
