# frozen_string_literal: true

# Job::Projection is a class responsible for projecting the state of a job
# based on its events. It also provides methods to fetch all jobs with pagination.
#
# @example
#   projection = Job::Projection.new
#   status = projection.project_status(job)
#   paginated_jobs = projection.fetch_paginated_jobs(page: 1, items: 20)

class Job::Projection
  ACTIVATED = 'activated'
  DEACTIVATED = 'deactivated'

  # Initializes a new instance of Job::Projection
  #
  # @param pagination_service [PaginationService] the service to use for pagination
  def initialize(pagination_service = PaginationService.new)
    @pagination_service = pagination_service
  end

  # Projects the status of a job based on its events
  #
  # @param job [Job] the job to project
  # @return [String] the projected status of the job
  def project_status(job)
    events = job.job_events.order(:created_at)
    job_status = DEACTIVATED
    events.each do |event|
      job_status = apply_event(event, job_status)
    end
    job_status
  end

  # Fetches jobs with pagination
  #
  # @param page [Integer] the page number to fetch (default: 1)
  # @param items [Integer] the number of items per page (default: 20)
  # @return [Array] an array containing a Pagy object and the fetched jobs
  def fetch_paginated_jobs(page: Paginatable::PAGE, items: Paginatable::ITEMS)
    @pagination_service.paginate(Job.all.includes(:applications), page:, items:)
  end

  # Returns a hash containing a Pagy object and all jobs,
  # each job is represented as a hash with its details.
  #
  # @param page [Integer] the page number to fetch (default: 1)
  # @param items [Integer] the number of items per page (default: 20)
  # @return [Hash] a hash containing a Pagy object and the jobs
  def fetch_all(page: Paginatable::PAGE, items: Paginatable::ITEMS)
    pagy, jobs = fetch_paginated_jobs(page:, items:)
    {
      pagy:,
      jobs: jobs.map { |job| job_details(job) }
    }
  end

  private

  def job_details(job)
    applications = job.applications.map { |app| Application::Projection.new.project_status(app) }

    {
      name: job.title,
      status: project_status(job),
      hired_count: applications.count { |status| status == Application::Projection::HIRED },
      rejected_count: applications.count { |status| status == Application::Projection::REJECTED },
      ongoing_count: applications.count do |status|
                       ![Application::Projection::HIRED, Application::Projection::REJECTED].include?(status)
                     end
    }
  end

  # Applies an event to the current status of a job
  #
  # @param event [Job::Event] the event to apply
  # @param job_status [String] the current status of the job
  # @return [String] the new status of the job after applying the event
  def apply_event(event, job_status)
    case event.type
    when 'Job::Event::Activated'
      ACTIVATED
    when 'Job::Event::Deactivated'
      DEACTIVATED
    else
      job_status
    end
  end
end
