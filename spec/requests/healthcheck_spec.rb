# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Healthcheck', type: :request do
  describe 'GET /healthcheck' do
    it 'returns http success' do
      get '/healthcheck'
      expect(response).to have_http_status(:success)
    end

    it 'returns a status of ok' do
      get '/healthcheck'
      json_response = JSON.parse(response.body)
      expect(json_response['status']).to eq('ok')
    end
  end
end
