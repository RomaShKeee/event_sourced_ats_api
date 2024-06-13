# frozen_string_literal: true

module V1
  class JobsController < ApplicationController
    include Paginatable

    def index
      jobs = Job::Projection.new(pagination_service).fetch_all(**pagination_params)
      render json: jobs
    end
  end
end
