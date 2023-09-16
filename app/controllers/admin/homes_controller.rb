class Admin::HomesController < ApplicationController
  def search
    @model = params[:model]
    @content = params[:content]
    @result = search_for(@model, @content)
  end

  private

  def search_for(model, content)
    if model == 'member'
      Member.where(
        'name LIKE ? OR email LIKE ?',
        "%#{content}%", "%#{content}%")
    else
      Post.where(
        'title LIKE ? OR body LIKE ?',
        "%#{content}%", "%#{content}%")
    end
  end
end
