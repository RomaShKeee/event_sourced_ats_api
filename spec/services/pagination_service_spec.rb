# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PaginationService do
  describe '#paginate' do
    let(:collection) { Job.where(id: FactoryBot.create_list(:job, 100).pluck(:id)).order(:created_at) }
    let(:service) { described_class.new }

    context 'when page 1 is requested' do
      it 'returns the first 20 items' do
        _, paginated_collection = service.paginate(collection, page: 1, items: 20)
        expect(paginated_collection.pluck(:id)).to eq(collection.first(20).pluck(:id))
      end
    end

    context 'when page 5 is requested' do
      it 'returns the items from 81 to 100' do
        _, paginated_collection = service.paginate(collection, page: 5, items: 20)
        expect(paginated_collection.pluck(:id)).to eq(collection.last(20).pluck(:id))
      end
    end

    context 'when 10 items per page are requested' do
      it 'returns the first 10 items for page 1' do
        _, paginated_collection = service.paginate(collection, page: 1, items: 10)
        expect(paginated_collection.pluck(:id)).to eq(collection.first(10).pluck(:id))
      end

      it 'returns the items from 11 to 20 for page 2' do
        _, paginated_collection = service.paginate(collection, page: 2, items: 10)
        expect(paginated_collection).to eq(collection.offset(10).limit(10))
      end
    end
  end
end
