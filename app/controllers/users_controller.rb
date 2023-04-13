class UsersController < ApplicationController
  # Controller to for users to sign up for the application

  before_action :authenticate_user!

  def index
    @users = User.all
  end

  def show
    # @user = User.find(params[:id])
    return if current_user.nil?

    @user = current_user
    @created_events = @user.created_events
    @attended_events = @user.event_attendees

    event_ids = @user.event_attendees.pluck(:attended_event_id) # this retrieves an array of event_ids from the attended_event table

    # both of these variables are used to display the past and future events that the user has attended. The records come from the events table, NOT the event_attendees table
    @past_attended_events = Event.where(id: event_ids).where('events.event_date < ?', Time.now) # the event_ids array is used to retrieve only the attended events from the events table, it is then filtered to only retrieve events that have a date less than the current time
    @future_attended_events = Event.where(id: event_ids).where('events.event_date >= ?', Time.now) # the event_ids array is used to retrieve only the attended events from the events table, it is then filtered to only retrieve events that have a date greater than or equal to the current time
  end

  # def show
  #   return if current_user.nil?

  #   @user = current_user
  #   @created_events = @user.created_events
  #   event_ids = @user.event_attendees.pluck(:event_id)
  #   @past_attended_events = Event.where(id: event_ids).where('events.event_date < ?', Time.now)
  #   @future_attended_events = Event.where(id: event_ids).where('events.event_date >= ?', Time.now)
  # end
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = 'User was successfully created.'
      redirect_to @user
    else
      flash[:error] = @user.errors.full_messages.join(', ')
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to @user
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to new_user_session_path
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password)
  end
end
