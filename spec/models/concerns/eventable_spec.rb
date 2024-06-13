# frozen_string_literal: true

# spec/models/concerns/eventable_spec.rb

require 'rails_helper'

RSpec.describe Eventable, type: :model do
  let!(:job) { FactoryBot.create(:job) }
  let(:event) { Job::Event::Activated.new(job:) }

  describe 'scopes' do
    it 'orders by created_at in descending order' do
      first_event = Job::Event::Activated.create!(created_at: 1.day.ago, job:)
      second_event = Job::Event::Activated.create!(created_at: 2.days.ago, job:)
      expect(Job::Event::Activated.recent_first).to eq [first_event, second_event]
    end
  end

  describe '#aggregate_name' do
    it 'returns the name of the aggregate the event belongs to' do
      expect(event.class.aggregate_name).to eq :job
    end
  end

  describe '#event_name' do
    it 'returns the underscored class name of the event' do
      expect(event.class.event_name).to eq 'job/event/activated'
    end
  end

  describe '#apply' do
    it 'returns the aggregate' do
      aggregate = job
      expect(event.apply(aggregate)).to eq aggregate
    end
  end

  describe '#aggregate=' do
    it 'sets the aggregate the event belongs to' do
      aggregate = job
      event.aggregate = aggregate
      expect(event.aggregate).to eq aggregate
    end
  end

  describe '#aggregate' do
    it 'returns the aggregate the event belongs to' do
      aggregate = job
      event.aggregate = aggregate
      expect(event.aggregate).to eq aggregate
    end
  end

  describe '#aggregate_id=' do
    it 'sets the ID of the aggregate the event belongs to' do
      event.aggregate_id = job.id
      expect(event.aggregate_id).to eq job.id
    end
  end

  describe '#aggregate_id' do
    it 'returns the ID of the aggregate the event belongs to' do
      event.aggregate_id = job.id
      expect(event.aggregate_id).to eq job.id
    end
  end

  describe '#build_aggregate' do
    it 'builds a new aggregate instance' do
      expect(event.build_aggregate).to be_a(Job)
    end
  end
end
