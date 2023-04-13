class CreateEventAttendees < ActiveRecord::Migration[7.0]
  def change
    create_table :event_attendees do |t|
      t.timestamps
    end
  end
end
