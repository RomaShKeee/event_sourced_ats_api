# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Job, type: :model do
  it 'has a valid factory' do
    expect(FactoryBot.create(:job)).to be_valid
  end

  it 'has many applications' do
    job = FactoryBot.create(:job)
    application1 = FactoryBot.create(:application, job:)
    application2 = FactoryBot.create(:application, job:)
    expect(job.applications).to include(application1, application2)
  end

  it 'has many job events' do
    job = FactoryBot.create(:job)
    event1 = FactoryBot.create(:job_event, job:)
    event2 = FactoryBot.create(:job_event, job:)
    expect(job.job_events).to include(event1, event2)
  end
end
