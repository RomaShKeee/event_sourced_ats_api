class Application < ApplicationRecord
  has_many :application_events, dependent: :destroy, class_name: 'Application::Event'
  belongs_to :job
end
