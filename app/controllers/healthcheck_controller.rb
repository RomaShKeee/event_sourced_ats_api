# frozen_string_literal: true

class HealthcheckController < ApplicationController
  # GET /healthcheck
  def index
    render json: { status: 'ok' }
  end
end
