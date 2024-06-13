# frozen_string_literal: true

class Application::Event::Hired < Application::Event
  store_accessor :data, :hire_date

  # Applies the event to the given aggregate.
  #
  # @param aggregate [Object] the aggregate to apply the event to
  # @return [Object] the modified aggregate
  def apply(aggregate)
    aggregate.hire_date = hire_date
    aggregate
  end
end
