class EventAttendeesController < ApplicationController
  before_action :authenticate_user!

  def index
    # @user = current_user
    # @created_events = @user.created_events
    @event_attendees = EventAttendee.all
  end

  def show
    @event_attendee = EventAttendee.find(params[:id])
  end

  def new
    @event_attendee = EventAttendee.new
  end

  def create
    @event_attendee = EventAttendee.new(event_attendee_params)
    # @event = current_user.created_events.build(event_params)
    if @event_attendee.save
      redirect_to @event_attendee
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @event_attendee = EventAttendee.find(params[:id])
  end

  def update
    @event_attendee = EventAttendee.find(params[:id])
    if @event_attendee.update(eventattendee_params)
      redirect_to @event_attendee
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @event_attendee = EventAttendee.find(params[:id])
    @event_attendee.destroy
    redirect_to event_attendees_path
  end

  private

  def event_attendee_params
    params.require(:event_attendee).permit(:attendee_id, :attended_event_id)
  end
end
