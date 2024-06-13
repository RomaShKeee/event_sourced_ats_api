# frozen_string_literal: true

FactoryBot.define do
  factory :application do
    candidate_name { 'John Doe' }
    association :job
  end
end
