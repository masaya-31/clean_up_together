class Public::EventsController < ApplicationController
  def index
    @events = Event.all
    @event = Event.new
  end

  def create
    event = Event.new(event_params)
    if event.save
      redirect_to member_events_path(current_member)
    else
      redirect_to member_path(current_member)
    end
  end

  private

  def event_params
    params.require(:event).permit(:title, :start_time)
  end
end
