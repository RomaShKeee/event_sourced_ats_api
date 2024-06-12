require 'rails_helper'

RSpec.describe Job, type: :model do
  it 'has a valid factory' do
    expect(FactoryBot.create(:job)).to be_valid
  end

  it 'has many applications' do
    job = FactoryBot.create(:job)
    application1 = FactoryBot.create(:application, job: job)
    application2 = FactoryBot.create(:application, job: job)
    expect(job.applications).to include(application1, application2)
  end

  it 'has many job events' do
    job = FactoryBot.create(:job)
    event1 = FactoryBot.create(:job_event, job: job)
    event2 = FactoryBot.create(:job_event, job: job)
    expect(job.job_events).to include(event1, event2)
  end

  # describe '#status' do
  #   it 'returns deactivated if no events' do
  #     job = FactoryBot.create(:job)
  #     expect(job.status).to eq('deactivated')
  #   end

  #   it 'returns activated if last event is JobEvent::Activated' do
  #     job = FactoryBot.create(:job)
  #     FactoryBot.create(:job_event_activated, job: job)
  #     expect(job.status).to eq('activated')
  #   end

  #   it 'returns deactivated if last event is JobEvent::Deactivated' do
  #     job = FactoryBot.create(:job)
  #     FactoryBot.create(:job_event_activated, job: job)
  #     FactoryBot.create(:job_event_deactivated, job: job)
  #     expect(job.status).to eq('deactivated')
  #   end
  # end
end
