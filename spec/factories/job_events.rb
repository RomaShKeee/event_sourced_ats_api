# frozen_string_literal: true

FactoryBot.define do
  factory :job_event, class: Job::Event do
    association :job
    type { 'Job::Event' }
    data { {} }

    factory :job_event_activated, class: Job::Event::Activated do
      type { 'Job::Event::Activated' }
    end

    factory :job_event_deactivated, class: Job::Event::Deactivated do
      type { 'Job::Event::Deactivated' }
    end
  end
end
