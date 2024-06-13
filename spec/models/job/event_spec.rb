# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Job::Event, type: :model do
  let!(:job) { FactoryBot.create(:job) }
  let!(:activated_event) { FactoryBot.create(:job_event_activated, job:) }
  let!(:deactivated_event) { FactoryBot.create(:job_event_deactivated, job:) }

  describe '#replay' do
    it 'replays all events on the job and updates the status' do
      described_class.replay_events(job)

      # After replaying events, the final status should be 'deactivated'
      expect(Job::Projection.new.project_status(job)).to eq('deactivated')
    end
  end
end
