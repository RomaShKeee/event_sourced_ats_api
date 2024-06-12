class Job < ApplicationRecord
  has_many :job_events, dependent: :destroy, class_name: 'Job::Event'
  has_many :applications, dependent: :destroy
end
