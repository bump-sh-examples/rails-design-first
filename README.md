# Rails Hello OpenAPI

This repository was built as sample code for the Bump.sh guide on _[Using OpenAPI to simplify building and testing Ruby on Rails APIs](https://docs.bump.sh/guides/openapi/design-first-rails/)_. Learn to use the API Design First workflow, and simplify your Rails code by not having to repeat your API contract in validation and contract testing as well as documentation. Just do it once, make easy code, then pop it all onto Bump.sh to have [great API documentation](https://bump.sh/bump-examples/hub/code-samples/doc/rails-design-first).

## Usage

Clone the repository down to give it a try.

```
# Set everything up
$ bundle install

# Start the server
$ rails s

# Poke the API and get automated  errors
$ curl -X POST http://localhost:3000/widgets -H "Content-Type: application/json" -d '{}'  | jq .

{
  "title": "Bad Request Body",
  "status": 400,
  "errors": [
    {
      "message": "object at root is missing required properties: name",
      "pointer": "",
      "code": "required"
    }
  ]
}
```

Give it a try, play around with the OpenAPI, and see how it responds to different scenarios. 

Then you can run `rspec` to see if the API responses match what OpenAPI expect, which when implemented in your application will help make sure your API is actually doing what your docs are saying, or make sure your docs are saying what your API is doing, whichever way round you prefer to think of it.

Preview how the API reference docs look [on Bump.sh](https://bump.sh/bump-examples/hub/code-samples/doc/rails-design-first).
