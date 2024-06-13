# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Jobs', type: :request do
  it 'lists all jobs with correct details' do
    job = Job.create!(title: 'Software Engineer', description: 'Develop software solutions.')
    get jobs_path
    expect(response).to have_http_status(:success)
    expect(JSON.parse(response.body).first['status']).to eq('activated')
  end
end
