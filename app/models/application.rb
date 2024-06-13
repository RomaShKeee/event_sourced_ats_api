# frozen_string_literal: true

# The Application class represents a job application in the system.
# It has a one-to-many relationship with Application::Event and a one-to-one relationship with Job.
# The `data` attribute is a store accessor that allows you to store key-value pairs in a hash.
# It includes attributes like `hire_date`, `interview_date`, and `content`.
#
# @!attribute [rw] hire_date
#   @return [Date] the date the applicant was hired
# @!attribute [rw] interview_date
#   @return [Date] the date of the interview
# @!attribute [rw] content
#   @return [String] the content of the application
#
# @!method application_events
#   @return [ActiveRecord::Associations::CollectionProxy<Application::Event>] the events associated with this application
# @!method job
#   @return [Job] the job associated with this application
class Application < ApplicationRecord
  has_many :application_events, dependent: :destroy, class_name: 'Application::Event'
  belongs_to :job

  store_accessor :data, :hire_date, :interview_date, :content
end
