# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Application::Projection, type: :model do
  let!(:job) { FactoryBot.create(:job) }
  let!(:activated_event) { FactoryBot.create(:job_event_activated, job:) }
  let!(:application) { FactoryBot.create(:application, job:) }
  let!(:interview_event) { FactoryBot.create(:application_event_interview, application:) }
  let!(:hired_event) { FactoryBot.create(:application_event_hired, application:) }
  let(:pagination_service) { PaginationService.new }

  describe '.project_status' do
    it 'calculates the application status based on events' do
      projection = described_class.new(pagination_service)
      expect(projection.project_status(application)).to eq(Application::Projection::HIRED)
    end
  end

  describe '.fetch_all' do
    it 'returns a list of applications with their statuses and notes count' do
      projection = described_class.new(pagination_service)
      result = projection.fetch_all
      applications = result[:applications]
      expect(applications.first[:job_name]).to eq(job.title)
      expect(applications.first[:candidate_name]).to eq(application.candidate_name)
      expect(applications.first[:status]).to eq(Application::Projection::HIRED)
      expect(applications.first[:notes_count]).to eq(0)
      expect(applications.first[:interview_date]).to eq(interview_event.data['interview_date'])
    end
  end

  describe '.fetch_paginated_applications_for_activated_jobs' do
    it 'returns paginated applications for activated jobs' do
      projection = described_class.new(pagination_service)
      pagy, records = projection.fetch_paginated_applications_for_activated_jobs(page: 1, items: 10)
      expect(records.count).to eq(1)
      expect(pagy.pages).to eq(1)
    end
  end
end
