require 'rails_helper'

RSpec.describe Application, type: :model do
  it 'has a valid factory' do
    expect(FactoryBot.create(:application)).to be_valid
  end

  it 'belongs to a job' do
    job = FactoryBot.create(:job)
    application = FactoryBot.create(:application, job: job)
    expect(application.job).to eq(job)
  end

  it 'has many application events' do
    application = FactoryBot.create(:application)
    event1 = FactoryBot.create(:application_event, application: application)
    event2 = FactoryBot.create(:application_event, application: application)
    expect(application.application_events).to include(event1, event2)
  end

  # describe '#status' do
  #   it 'returns applied if no events' do
  #     application = FactoryBot.create(:application)
  #     expect(application.status).to eq('applied')
  #   end

  #   it 'returns interview if last event is ApplicationEvent::Interview' do
  #     application = FactoryBot.create(:application)
  #     FactoryBot.create(:application_event_interview, application: application)
  #     expect(application.status).to eq('interview')
  #   end

  #   it 'returns hired if last event is ApplicationEvent::Hired' do
  #     application = FactoryBot.create(:application)
  #     FactoryBot.create(:application_event_interview, application: application)
  #     FactoryBot.create(:application_event_hired, application: application)
  #     expect(application.status).to eq('hired')
  #   end

  #   it 'returns rejected if last event is ApplicationEvent::Rejected' do
  #     application = FactoryBot.create(:application)
  #     FactoryBot.create(:application_event_interview, application: application)
  #     FactoryBot.create(:application_event_rejected, application: application)
  #     expect(application.status).to eq('rejected')
  #   end
  # end

  # describe '#notes_count' do
  #   it 'returns the correct number of notes' do
  #     application = FactoryBot.create(:application)
  #     FactoryBot.create_list(:application_event_note, 3, application: application)
  #     expect(application.notes_count).to eq(3)
  #   end
  # end

  # describe '#last_interview_date' do
  #   it 'returns the date of the last interview' do
  #     application = FactoryBot.create(:application)
  #     date = '2023-01-15'
  #     FactoryBot.create(:application_event_interview, application: application, data: { interview_date: date })
  #     expect(application.last_interview_date).to eq(date)
  #   end
  # end
end
