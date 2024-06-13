# frozen_string_literal: true

module V1
  class ApplicationsController < ApplicationController
    include Paginatable

    def index
      applications = Application::Projection.new(pagination_service).fetch_all(
        **pagination_params
      )
      render json: applications
    end
  end
end
