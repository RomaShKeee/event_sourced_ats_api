# frozen_string_literal: true

FactoryBot.define do
  factory :application_event, class: Application::Event do
    association :application
    type { 'Application::Event' }
    data { {} }

    factory :application_event_interview, class: Application::Event::Interview do
      type { 'Application::Event::Interview' }
      data { { interview_date: '2023-01-15' } }
    end

    factory :application_event_hired, class: Application::Event::Hired do
      type { 'Application::Event::Hired' }
      data { { hire_date: '2023-02-01' } }
    end

    factory :application_event_rejected, class: Application::Event::Rejected do
      type { 'Application::Event::Rejected' }
    end

    factory :application_event_note, class: Application::Event::Note do
      type { 'Application::Event::Note' }
      data { { content: 'This is a note' } }
    end
  end
end
