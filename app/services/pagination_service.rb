# frozen_string_literal: true

# PaginationService is a class responsible for paginating a collection of items.
# It uses the Pagy library for pagination.
#
# @example
#   service = PaginationService.new
#   pagy, paginated_collection = service.paginate(collection, page: 1, items: 20)
class PaginationService
  # Initializes a new instance of PaginationService
  #
  # @param pagy_class [Class] the class to use for pagination (default: Pagy)
  def initialize(pagy_class = Pagy)
    @pagy_class = pagy_class
  end

  # Paginates a collection of items
  #
  # @param collection [ActiveRecord::Relation, Array] the collection to paginate
  # @param page [Integer] the page number to fetch (default: 1)
  # @param items [Integer] the number of items per page (default: 20)
  # @return [Array] an array containing a Pagy object and the paginated collection
  def paginate(collection, page:, items:)
    pagy = @pagy_class.new(count: collection.count, page:, items:)
    [pagy, collection.offset(pagy.offset).limit(pagy.items)]
  end
end
