FactoryBot.define do
  factory :application_event, class: Application::Event do
    association :application
    type { "Application::Event" }
    data { {} }

    factory :application_event_interview, class: 'ApplicationEvent::Interview' do
      type { 'ApplicationEvent::Interview' }
      data { { interview_date: '2023-01-15' } }
    end

    factory :application_event_hired, class: 'ApplicationEvent::Hired' do
      type { 'ApplicationEvent::Hired' }
      data { { hire_date: '2023-02-01' } }
    end

    factory :application_event_rejected, class: 'ApplicationEvent::Rejected' do
      type { 'ApplicationEvent::Rejected' }
    end

    factory :application_event_note, class: 'ApplicationEvent::Note' do
      type { 'ApplicationEvent::Note' }
      data { { content: 'This is a note' } }
    end
  end
end
