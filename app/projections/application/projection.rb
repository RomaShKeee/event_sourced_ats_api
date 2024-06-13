# frozen_string_literal: true

# Application::Projection is a class responsible for projecting the state of an application
# based on its events. It also provides methods to fetch applications for activated jobs
# with pagination.
#
# @example
#   projection = Application::Projection.new
#   status = projection.project_status(application)
#   paginated_applications = projection.fetch_paginated_applications_for_activated_jobs(page: 1, items: 20)
class Application::Projection
  INTERVIEW = 'interview'
  HIRED = 'hired'
  REJECTED = 'rejected'
  APPLIED = 'applied'

  # Initializes a new instance of Application::Projection
  #
  # @param pagination_service [PaginationService] the service to use for pagination
  def initialize(pagination_service = PaginationService.new)
    @pagination_service = pagination_service
  end

  # Projects the status of an application based on its events
  #
  # @param application [Application] the application to project
  # @return [String] the projected status of the application
  def project_status(application)
    events = application.application_events.order(:created_at)
    application_status = APPLIED
    events.each do |event|
      application_status = apply_event(event, application_status)
    end
    application_status
  end

  # Fetches applications for activated jobs with pagination
  #
  # @param page [Integer] the page number to fetch (default: 1)
  # @param items [Integer] the number of items per page (default: 20)
  # @return [Array] an array containing a Pagy object and the fetched applications
  def fetch_paginated_applications_for_activated_jobs(page: Paginatable::PAGE, items: Paginatable::ITEMS)
    @pagination_service.paginate(
      Application.joins(:job, :application_events)
                 .where(jobs: { id: Job.joins(:job_events).where(job_events: { type: 'Job::Event::Activated' }).select(:id) })
                 .includes(:job, :application_events),
      page:,
      items:
    )
  end

  # Returns a hash containing a Pagy object and applications for activated jobs,
  # each application is represented as a hash with its details.
  #
  # @param page [Integer] the page number to fetch
  # @param items [Integer] the number of items per page
  # @return [Hash] a hash containing a Pagy object and the applications
  def fetch_all(page: Paginatable::PAGE, items: Paginatable::ITEMS)
    pagy, applications = fetch_paginated_applications_for_activated_jobs(page:, items:)
    {
      pagy:,
      applications: applications.map { |app| application_details(app) }
    }
  end

  private

  def application_details(application)
    notes_events_count = application.application_events.where(type: 'Application::Event::Note').count
    {
      job_name: application.job.title,
      candidate_name: application.candidate_name,
      status: project_status(application),
      notes_count: notes_events_count,
      interview_date: application.interview_date
    }
  end

  # Applies an event to the current status of an application
  #
  # @param event [Application::Event] the event to apply
  # @param application_status [String] the current status of the application
  # @return [String] the new status of the application after applying the event
  def apply_event(event, application_status)
    case event.type
    when 'Application::Event::Interview'
      INTERVIEW
    when 'Application::Event::Hired'
      HIRED
    when 'Application::Event::Rejected'
      REJECTED
    else
      application_status
    end
  end
end
