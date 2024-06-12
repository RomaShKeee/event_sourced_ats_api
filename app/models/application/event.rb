class Application::Event < ApplicationRecord
  self.table_name = "application_events"

  belongs_to :application
end

