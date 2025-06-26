FactoryBot.define do
  factory :widget do
    name { "Widget #{rand(1000)}" }
  end
end
