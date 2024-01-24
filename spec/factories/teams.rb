# frozen_string_literal: true

FactoryBot.define do
  factory :team do
    name { Faker::Team.name }
    association :leader, factory: :member
  end
end
