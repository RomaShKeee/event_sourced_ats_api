# frozen_string_literal: true

class Application::Event::Note < Application::Event
  store_accessor :data, :content

  def apply(aggregate)
    aggregate.content = content
    aggregate
  end
end
