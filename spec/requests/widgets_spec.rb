require "rails_helper"

RSpec.describe 'Widgets Requests', type: :request do

  describe "GET /widgets" do
    it 'responds with 200' do
      create_list(:widget, 3)

      get '/widgets'

      expect(response).to have_http_status(:ok)
      expect(response).to match_openapi_doc(OPENAPI_DOC)
    end
  end

  describe "GET /widgets/{id}" do
    it 'responds with 200 for existing record' do
      widget = create(:widget)

      get '/widgets/' + widget.id
      expect(response).to have_http_status(:ok)
      expect(response).to match_openapi_doc(OPENAPI_DOC)
    end

    it 'responds with 404 for non-existing record' do
      get '/widgets/' + SecureRandom.uuid_v7
      expect(response).to have_http_status(:not_found)
      expect(response).to match_openapi_doc(OPENAPI_DOC)
    end
  end

  describe "POST /widgets" do
    it 'responds with 201 when valid' do
      post '/widgets', params: { name: 'foo' }.to_json, headers: { 'content-type' => "application/json" }
      expect(response).to have_http_status(:created)
      expect(response).to match_openapi_doc(OPENAPI_DOC)
      
      # Get the created widget
      widget = Widget.last

      # Seeing as the controller does not return the created object, we check for the Location header
      expect(response).to have_header('Location')
      expect(response.headers['Location']).to eq(widget_url(widget.id))
    end

    it 'responds with 400 when invalid' do
      post '/widgets', params: { other_thing: 'irrelevant' }.to_json, headers: { 'content-type' => "application/json" }
      expect(response).to have_http_status(:bad_request)
      expect(response).to match_openapi_doc(OPENAPI_DOC)
    end
  end

  describe "PUT /widgets/{id}" do
    it 'responds with 200 when valid' do
      widget = create(:widget)

      put '/widgets/' + widget.id, params: { name: 'bar' }.to_json, headers: { 'content-type' => "application/json" }
      expect(response).to have_http_status(:ok)
      expect(response).to match_openapi_doc(OPENAPI_DOC)
    end

    it 'responds with 400 when invalid' do
      widget = create(:widget)

      put '/widgets/' + widget.id, params: { other_thing: 'irrelevant' }.to_json, headers: { 'content-type' => "application/json" }
      expect(response).to have_http_status(:bad_request)
      expect(response).to match_openapi_doc(OPENAPI_DOC)
    end

    it 'responds with 404 for non-existing record' do
      put '/widgets/' + SecureRandom.uuid_v7, params: { name: 'bar' }.to_json, headers: { 'content-type' => "application/json" }
      expect(response).to have_http_status(:not_found)
      expect(response).to match_openapi_doc(OPENAPI_DOC)
    end
  end

  describe "DELETE /widgets/{id}" do
    it 'responds with 204 for existing record' do
      widget = create(:widget)

      delete "/widgets/#{widget.id}"
      expect(response).to have_http_status(:no_content)
      expect(response).to match_openapi_doc(OPENAPI_DOC)

      # Ensure the widget was deleted
      expect(Widget.exists?(widget.id)).to be_falsey
    end

    it 'responds with 404 for non-existing record' do
      delete '/widgets/' + SecureRandom.uuid_v7
      expect(response).to have_http_status(:not_found)
      expect(response).to match_openapi_doc(OPENAPI_DOC)
    end
  end
end
