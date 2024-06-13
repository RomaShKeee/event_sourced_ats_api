# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Job::Projection, type: :model do
  let!(:job) { FactoryBot.create(:job) }
  let!(:activated_event) { FactoryBot.create(:job_event_activated, job:) }
  let!(:application) { FactoryBot.create(:application, job:) }
  let!(:interview_event) { FactoryBot.create(:application_event_interview, application:) }
  let!(:hired_event) { FactoryBot.create(:application_event_hired, application:) }
  let(:pagination_service) { PaginationService.new }

  describe '.project_status' do
    it 'calculates the job status based on events' do
      projection = described_class.new(pagination_service)
      expect(projection.project_status(job)).to eq(Job::Projection::ACTIVATED)
    end
  end

  describe '.fetch_all' do
    it 'returns a list of jobs with their statuses and application counts' do
      projection = described_class.new(pagination_service)
      result = projection.fetch_all
      jobs = result[:jobs]
      expect(jobs.first[:name]).to eq(job.title)
      expect(jobs.first[:status]).to eq(Job::Projection::ACTIVATED)
      expect(jobs.first[:hired_count]).to eq(1)
      expect(jobs.first[:rejected_count]).to eq(0)
      expect(jobs.first[:ongoing_count]).to eq(0)
    end
  end

  describe '.fetch_paginated_jobs' do
    it 'returns paginated jobs' do
      projection = described_class.new(pagination_service)
      pagy, records = projection.fetch_paginated_jobs(page: 1, items: 10)
      expect(records.count).to eq(1)
      expect(pagy.pages).to eq(1)
    end
  end
end
