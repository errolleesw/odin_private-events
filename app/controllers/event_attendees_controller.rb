class EventAttendeesController < ApplicationController
  before_action :authenticate_user!

  def index
    # @user = current_user
    # @created_events = @user.created_events
    @eventattendees = EventAttendee.all
  end

  def show
    @eventattendees = EventAttendee.find(params[:id])
  end

  def new
    @eventattendees = EventAttendee.new
  end

  def create
    @eventattendees = EventAttendee.new(eventattendee_params)
    # @event = current_user.created_events.build(event_params)
    if @eventattendees.save
      redirect_to @eventattendees
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @eventattendees = EventAttendee.find(params[:id])
  end

  def update
    @eventattendees = EventAttendee.find(params[:id])
    if @eventattendees.update(event_params)
      redirect_to @eventattendees
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @eventattendees = EventAttendee.find(params[:id])
    @eventattendees.destroy
    redirect_to events_path
  end

  private

  def eventattendee_params
    params.require(:event).permit(:attendee_id, :attendee_event_id)
  end
end
