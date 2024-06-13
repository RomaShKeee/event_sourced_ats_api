# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Application, type: :model do
  it 'has a valid factory' do
    expect(FactoryBot.create(:application)).to be_valid
  end

  it 'belongs to a job' do
    job = FactoryBot.create(:job)
    application = FactoryBot.create(:application, job:)
    expect(application.job).to eq(job)
  end

  it 'has many application events' do
    application = FactoryBot.create(:application)
    event1 = FactoryBot.create(:application_event, application:)
    event2 = FactoryBot.create(:application_event, application:)
    expect(application.application_events).to include(event1, event2)
  end
end
