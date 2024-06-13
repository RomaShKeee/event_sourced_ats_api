# frozen_string_literal: true

module Eventable
  extend ActiveSupport::Concern

  included do
    before_validation :preset_aggregate
    before_create :apply_and_persist

    scope :recent_first, -> { reorder('created_at DESC') }
  end

  class_methods do
    # Returns the name of the aggregate the event belongs to.
    #
    # @return [String] the name of the aggregate
    # @raise [RuntimeError] if no aggregate association is found
    def aggregate_name
      inferred_aggregate = reflect_on_all_associations(:belongs_to).first
      raise 'Events must belong to an aggregate' if inferred_aggregate.nil?

      inferred_aggregate.name
    end

    # Returns the underscored class name of the event.
    #
    # @return [String] the underscored class name of the event
    def event_name
      name.underscore
    end
  end

  # Applies the event to the given aggregate.
  #
  # @param aggregate [Object] the aggregate to apply the event to
  # @return [Object] the modified aggregate
  def apply(aggregate)
    aggregate
  end

  # Sets the aggregate the event belongs to.
  #
  # @param model [Object] the aggregate model
  def aggregate=(model)
    public_send "#{self.class.aggregate_name}=", model
  end

  # Returns the aggregate the event belongs to.
  #
  # @return [Object] the aggregate
  def aggregate
    public_send self.class.aggregate_name
  end

  # Sets the ID of the aggregate the event belongs to.
  #
  # @param id [String] the ID of the aggregate
  def aggregate_id=(id)
    public_send "#{self.class.aggregate_name}_id=", id
  end

  # Returns the ID of the aggregate the event belongs to.
  #
  # @return [String] the ID of the aggregate
  def aggregate_id
    public_send "#{self.class.aggregate_name}_id"
  end

  # Builds a new aggregate instance.
  #
  # @return [Object] the new aggregate instance
  def build_aggregate
    public_send "build_#{self.class.aggregate_name}"
  end

  private

  # Presets the aggregate for the event.
  def preset_aggregate
    self.aggregate ||= build_aggregate
  end

  # Applies the transformation to the aggregate and saves it.
  def apply_and_persist
    aggregate.lock! if aggregate.persisted?

    self.aggregate = apply(aggregate)

    aggregate.save!
    self.aggregate_id = aggregate.id if aggregate_id.nil?
  end
end
