# frozen_string_literal: true

# Paginatable provides a set of methods for handling pagination.
# It is intended to be used in controllers to extract pagination parameters from requests.
module Paginatable
  extend ActiveSupport::Concern

  PAGE = 1
  ITEMS = 20

  private

  # Creates a new instance of the PaginationService.
  #
  # @return [PaginationService] the new instance of the PaginationService.
  def pagination_service
    PaginationService.new
  end

  # Extracts the :page and :per_page parameters from the request parameters and provides default values if they are not present.
  # The :page parameter defaults to 1 and the :per_page parameter defaults to 20.
  #
  # @return [Hash] a hash with the :page and :items parameters.
  def pagination_params
    params.permit(:page, :per_page).to_h.symbolize_keys.tap do |hash|
      hash[:page] = (hash[:page].presence || PAGE).to_i
      hash[:items] = (hash[:per_page].presence || ITEMS).to_i
    end
  end
end
