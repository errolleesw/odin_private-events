class EventsController < ApplicationController
  before_action :authenticate_user!

  def index
    @user = current_user
    @created_events = @user.created_events
    @events = Event.all
    @past_events = Event.past
    @upcoming_events = Event.upcoming
  end

  def show
    @event = Event.find(params[:id])
    @attendees = @event.event_attendees
  end

  def new
    @event = Event.new
  end

  def create
    # @event = Event.new(event_params)
    @event = current_user.created_events.build(event_params)
    if @event.save
      redirect_to @event
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @event = Event.find(params[:id])
  end

  def update
    @event = Event.find(params[:id])
    if @event.update(event_params)
      redirect_to @event
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @event = Event.find(params[:id])
    @event.destroy
    redirect_to events_path
  end

  # define a new action attend to handle the request when a user clicks on the "attend" button

  def attend
    @event = Event.find(params[:id])
    @event_attendee = EventAttendee.new(attendee_id: current_user.id, attended_event_id: @event.id) # this creates a new EventAttendee record with the @event.id and the current_user.id as input parameters

    if @event_attendee.save
      redirect_to @event, notice: 'You have now attendeding this event.'
    else
      redirect_to @event, alert: 'There was an error. Please try again.'
    end
  end

  private

  def event_params
    params.require(:event).permit(:event_title, :event_date, :description, :location)
  end
end
