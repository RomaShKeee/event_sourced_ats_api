# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Application::Event, type: :model do
  let!(:job) { FactoryBot.create(:job) }
  let!(:application) { FactoryBot.create(:application, job:) }
  let!(:interview_event) do
    FactoryBot.create(:application_event_interview, application:, data: { interview_date: '2023-01-15' })
  end
  let!(:hired_event) do
    FactoryBot.create(:application_event_hired, application:, data: { hire_date: '2023-02-01' })
  end
  let!(:rejected_event) { FactoryBot.create(:application_event_rejected, application:) }

  describe '.replay_events' do
    it 'replays all events on the application and updates the status to the final state' do
      described_class.replay_events(application)

      # After replaying events, the final status should be 'rejected'
      expect(Application::Projection.new.project_status(application)).to eq('rejected')
      expect(application.interview_date).to eq('2023-01-15')
      expect(application.hire_date).to eq('2023-02-01')
    end
  end
end
