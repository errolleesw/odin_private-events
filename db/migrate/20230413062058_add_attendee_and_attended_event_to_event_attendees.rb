class AddAttendeeAndAttendedEventToEventAttendees < ActiveRecord::Migration[7.0]
  def change
    add_reference :event_attendees, :attendee, null: false, foreign_key: { to_table: :users }
    add_reference :event_attendees, :attended_event, null: false, foreign_key: { to_table: :events }
  end
end
