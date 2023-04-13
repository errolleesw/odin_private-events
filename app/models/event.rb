class Event < ApplicationRecord
  belongs_to :creator, class_name: 'User'
  has_many :event_attendees, foreign_key: :attended_event_id

  delegate :email, to: :creator, prefix: true

  # before_create :set_creator

  # private

  # def set_creator
  #   self.creator = current_user
  # end
end
