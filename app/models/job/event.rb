# frozen_string_literal: true

# The Event class represents an event associated with a job in the system.
# It includes the Eventable module, which provides additional functionality.
# The table name for this model is 'job_events'.
#
# @!method job
#   @return [Job] the job associated with this event
class Job::Event < ApplicationRecord
  include Eventable

  self.table_name = 'job_events'

  belongs_to :job, autosave: false

  # Replays the events for a given job
  #
  # @param job [Job] the job for which to replay events
  # @return [void]
  def self.replay_events(job)
    where(job:).order(:created_at).each do |event|
      event.replay(job)
    end
  end
end
