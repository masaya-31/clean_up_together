class Admin::HomesController < ApplicationController
  def search
    @model = params[:model]
    @content = params[:content]
    @result = search_for(@model, @content).page(params[:page])
    # いいね数順にタグを30件表示
    @favorited_tags = Tag.joins(:post_tags).group(:tag_id).order('count(post_id) desc').limit(30)
  end

  private

  # 管理者側の検索機能
  def search_for(model, content)
    # 会員の検索
    if model == 'member'
      Member.where(
        'name LIKE ? OR email LIKE ?',
        "%#{content}%", "%#{content}%")
    else
      # 投稿記事の検索
      Post.where(
        'title LIKE ? OR body LIKE ?',
        "%#{content}%", "%#{content}%")
    end
  end
end
