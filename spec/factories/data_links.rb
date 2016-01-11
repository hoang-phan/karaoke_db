FactoryGirl.define do
  factory :data_link do
    vol { rand(10) }
    link { Faker::Internet.url }
  end
end