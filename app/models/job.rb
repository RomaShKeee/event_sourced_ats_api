# frozen_string_literal: true

# The Job class represents a job in the system.
# It has a one-to-many relationship with Job::Event and Application.
# When a Job is destroyed, all associated Job::Event and Application records are also destroyed.
#
# @!method job_events
#   @return [ActiveRecord::Associations::CollectionProxy<Job::Event>] the events associated with this job
# @!method applications
#   @return [ActiveRecord::Associations::CollectionProxy<Application>] the applications associated with this job
class Job < ApplicationRecord
  has_many :job_events, dependent: :destroy, class_name: 'Job::Event'
  has_many :applications, dependent: :destroy
end
