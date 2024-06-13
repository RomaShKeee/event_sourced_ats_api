# frozen_string_literal: true

# The Event class represents an event associated with an application in the system.
# It includes the Eventable module, which provides additional functionality.
# The table name for this model is 'application_events'.
#
# @!method application
#   @return [Application] the application associated with this event
class Application::Event < ApplicationRecord
  include Eventable

  self.table_name = 'application_events'

  belongs_to :application, autosave: false

  # Replays the events for a given application
  #
  # @param application [Application] the application for which to replay events
  # @return [void]
  def self.replay_events(application)
    where(application:).order(:created_at).each do |event|
      event.replay(application)
    end
  end
end
