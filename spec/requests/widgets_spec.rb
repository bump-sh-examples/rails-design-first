require "rails_helper"

RSpec.describe 'widgets', type: :request do

  describe "GET /widgets" do
    it 'responds with 200 and matches the doc' do
      get '/widgets'
      expect(response).to have_http_status(:ok)
      expect(response).to match_openapi_doc(OPENAPI_DOC)
    end
  end
end
