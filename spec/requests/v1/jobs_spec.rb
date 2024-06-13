# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'V1::Jobs', type: :request do
  describe 'GET /v1/jobs' do
    it 'returns paginated jobs with their statuses and application counts' do
      job = FactoryBot.create(:job)
      FactoryBot.create(:job_event_activated, job:)
      application = FactoryBot.create(:application, job:)
      application_two = FactoryBot.create(:application, job:)
      application_three = FactoryBot.create(:application, job:)
      FactoryBot.create(:application_event_interview, application:)
      FactoryBot.create(:application_event_interview, application: application_two)
      FactoryBot.create(:application_event_hired, application:)
      FactoryBot.create(:application_event_rejected, application: application_three)

      get v1_jobs_path(page: 1, items: 10)

      expect(response).to have_http_status(:success)

      body = JSON.parse(response.body)
      expect(body['jobs'].first['name']).to eq(job.title)
      expect(body['jobs'].first['status']).to eq('activated')
      expect(body['jobs'].first['hired_count']).to eq(1)
      expect(body['jobs'].first['rejected_count']).to eq(1)
      expect(body['jobs'].first['ongoing_count']).to eq(1)
    end
  end
end
