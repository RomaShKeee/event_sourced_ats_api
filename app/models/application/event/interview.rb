# frozen_string_literal: true

class Application::Event::Interview < Application::Event
  store_accessor :data, :interview_date

  # Applies the event to the given aggregate.
  #
  # @param aggregate [Object] the aggregate to apply the event to
  # @return [Object] the modified aggregate
  def apply(aggregate)
    aggregate.interview_date = interview_date
    aggregate
  end
end
