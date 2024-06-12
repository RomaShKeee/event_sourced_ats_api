class Job::Event < ApplicationRecord
  self.table_name = "job_events"

  belongs_to :job
end
