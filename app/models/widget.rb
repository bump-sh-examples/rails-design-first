class Widget < ApplicationRecord
  attribute :id, :uuid_v7, default: -> { SecureRandom.uuid_v7 }
end
