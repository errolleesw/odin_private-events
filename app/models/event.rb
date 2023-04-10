class Event < ApplicationRecord
  belongs_to :creator, class_name: 'User'

  delegate :email, to: :creator, prefix: true

  # before_create :set_creator

  # private

  # def set_creator
  #   self.creator = current_user
  # end
end
