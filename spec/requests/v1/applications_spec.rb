# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'V1::Applications', type: :request do
  describe 'GET /v1/applications' do
    it 'returns paginated applications for activated jobs with their statuses and notes count' do
      job = FactoryBot.create(:job)
      FactoryBot.create(:job_event_activated, job:)
      application = FactoryBot.create(:application, job:)
      interview_event = FactoryBot.create(:application_event_interview, application:)
      FactoryBot.create(:application_event_hired, application:)
      FactoryBot.create(:application_event_note, application:)

      get v1_applications_path(page: 1, items: 10)

      expect(response).to have_http_status(:success)

      body = JSON.parse(response.body)
      expect(body['applications'].first['job_name']).to eq(job.title)
      expect(body['applications'].first['candidate_name']).to eq(application.candidate_name)
      expect(body['applications'].first['status']).to eq('hired')
      expect(body['applications'].first['notes_count']).to eq(1)
      expect(body['applications'].first['interview_date']).to eq(interview_event.data['interview_date'])
    end
  end
end
