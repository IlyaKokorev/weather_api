FactoryBot.define do
  factory :weather do
    temperature { rand(10..30) }
    timestamp { Time.now }

    trait :for_last_24_hours do
      transient do
        hours { 24 }
      end

      after(:build) do |_, evaluator|
        evaluator.hours.times do |hour|
          create(:weather, timestamp: hour.hours.ago)
        end
      end
    end
  end
end
