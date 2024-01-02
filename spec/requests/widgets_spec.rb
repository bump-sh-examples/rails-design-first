require 'swagger_helper'

RSpec.describe 'widgets', type: :request do

  path '/widgets' do

    get 'list widgets'  do
      produces 'application/json'

      response 200, 'successful' do
        header 'Cache-Control', schema: { type: :string }, description: 'This header declares the cacheability of the content so you can skip repeating requests.'
        
        schema type: 'array',
          items: {
            type: 'object',
            properties: {
              id: { 
                type: 'string',
                format: 'uuid',
                example: '123e4567-e89b-12d3-a456-426614174000',
              },
              title: { 
                type: 'string',
                example: 'Goblin Staff of Sparks',
              },
              created_at: {
                type: 'string',
                format: 'date-time',
              },
              updated_at: {
                type: 'string',
                format: 'date-time',
              },
            }
          }

        example 'application/json', :example_key, [
          {
            id: 1,
            title: 'Goblin Staff of Sparks',
          }
        ]
        run_test!
      end
      
      response 429, 'too many requests' do
        header 'X-Rate-Limit-Limit', schema: { type: :integer }, description: 'The number of allowed requests in the current period'
        header 'X-Rate-Limit-Remaining', schema: { type: :integer }, description: 'The number of remaining requests in the current period'
        header 'X-Rate-Limit-Reset', schema: { type: :integer }, description: 'The number of seconds left in the current period'
       
        run_test!
      end
    end

    post 'create widget' do
      consumes 'application/json'
      produces 'application/json'

      parameter name: :widget, in: :body, schema: {
        type: :object,
        properties: {
          title: { type: :string }
        },
        required: %w[title]
      }

      response 200, 'successful' do
        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end

      response 422, 'unprocessable entity' do
        schema type: 'object',
          properties: {
            errors: { 
              type: 'array',
              items: {
                type: 'object',
                properties: {
                  title: { type: 'string' },
                  detail: { type: 'string' },
                  code: { type: 'string' },
                }
              }
            }
          }
        run_test!
      end
    end
  end

  path '/widgets/{id}' do
    parameter name: 'id', in: :path, type: :string, description: 'The unique identifier of a widget.'

    get('show widget') do
      response 200, 'successful' do
        let(:id) { '123' }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end

    put('update widget') do
      response 200, 'successful' do
        let(:id) { '123' }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end

      response 422, 'unprocessable entity' do
      end
    end

  end
end
