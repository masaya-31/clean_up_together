class Public::HomesController < ApplicationController

  def top
    @posts = Post.all.order(created_at: :desc).limit(6).published
    # いいね数順に並べ替え
    @favorited_posts = Post.includes(:favorited_members).limit(6).published.sort {|a,b| b.favorited_members.size <=> a.favorited_members.size}
    @tags = Tag.all.limit(30)
    # 件数順に並び替え
    @favorited_tags = Tag.joins(:post_tags).group(:tag_id).order('count(post_id) desc')
  end

  def about
  end
end
