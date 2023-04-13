class Event < ApplicationRecord
  belongs_to :creator, class_name: 'User'
  has_many :event_attendees, foreign_key: :attended_event_id

  delegate :email, to: :creator, prefix: true

  scope :upcoming, -> { where 'event_date >= ?', Time.now }
  scope :past, -> { where 'event_date < ?', Time.now }

  # def self.past
  #   where('event_date < ?', Time.now)
  # end

  # def self.upcoming
  #   where('event_date >= ?', Time.now)
  # end

  # before_create :set_creator

  # private

  # def set_creator
  #   self.creator = current_user
  # end
end
