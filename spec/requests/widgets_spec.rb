require "rails_helper"

RSpec.describe 'widgets', type: :request do

  describe "GET /widgets" do
    it 'responds with 200' do
      get '/widgets'
      expect(response).to have_http_status(:ok)
      expect(response).to match_openapi_doc(OPENAPI_DOC)
    end
  end

  describe "POST /widgets" do
    it 'responds with 201 when valid' do
      post '/widgets', params: { name: 'foo' }.to_json, headers: { 'content-type' => "application/json" }
      expect(response).to have_http_status(:created)
      expect(response).to match_openapi_doc(OPENAPI_DOC)
    end

    it 'responds with 400 when invalid' do
      post '/widgets', params: { other_thing: 'irrelevant' }.to_json, headers: { 'content-type' => "application/json" }
      expect(response).to have_http_status(:bad_request)
      expect(response).to match_openapi_doc(OPENAPI_DOC)
    end
  end
end
