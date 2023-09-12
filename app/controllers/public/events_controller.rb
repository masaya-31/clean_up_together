class Public::EventsController < ApplicationController
  def index
    @events = current_member.events
  end

  def new
    @event = Event.new
    favorites = Favorite.where(member_id: current_member.id).pluck(:post_id)
    @favorite_posts = Post.find(favorites)
  end

  def edit
    @event = Event.find(params[:id])
    favorites = Favorite.where(member_id: current_member.id).pluck(:post_id)
    @favorite_posts = Post.find(favorites)
  end

  def create
    @event = Event.new(event_params)

    if params[:event][:select_post] == 'no_post'
      @event.post_id = -1
    elsif params[:event][:select_post] == 'my_post'
      @selected_post = current_member.posts.find(params[:member_post_id])
      @event.post_id = @selected_post.id
    elsif params[:event][:select_post] == 'favorite_post'
      @selected_post = Post.find(params[:favorite_post_id])
      @event.post_id = @selected_post.id
    end

    @event.member_id = current_member.id
    if @event.save
      redirect_to events_path
    else
      redirect_to new_event_path
    end
  end

  def update
    @event = Event.find(params[:id])
    if params[:event][:select_post] == 'no_post'
      @event.post_id = -1
    elsif params[:event][:select_post] == 'my_post'
      @selected_post = current_member.posts.find(params[:member_post_id])
      @event.post_id = @selected_post.id
    elsif params[:event][:select_post] == 'favorite_post'
      @selected_post = Post.find(params[:favorite_post_id])
      @event.post_id = @selected_post.id
    end

    @event.member_id = current_member.id
    if @event.update(event_params)
      redirect_to events_path
    else
      redirect_to member_path(current_member)
    end
  end

  def destroy
    event = Event.find(params[:id])
    event.destroy
    redirect_to events_path
  end

  private

  def event_params
    params.require(:event).permit(:title, :start_time, :member_id, :post_id, :select_post)
  end
end
