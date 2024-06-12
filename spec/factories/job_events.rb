FactoryBot.define do
  factory :job_event, class: Job::Event do
    association :job
    type { "Job::Event" }
    data { {} }

    factory :job_event_activated, class: 'JobEvent::Activated' do
      type { 'JobEvent::Activated' }
    end

    factory :job_event_deactivated, class: 'JobEvent::Deactivated' do
      type { 'JobEvent::Deactivated' }
    end
  end
end
