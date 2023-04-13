class EventAttendee < ApplicationRecord
  belongs_to :attendee, class_name: 'User'
  belongs_to :attended_event, class_name: 'Event'

  delegate :email, to: :attendee, prefix: true # enables the email field on the user object to be accessed via the attendee_email method

  delegate :event_title, to: :attended_event, prefix: true
  delegate :event_date, to: :attended_event, prefix: true
end
