FactoryBot.define do
  factory :hrm_data_point do
    session_id { "" }
    beats_per_minute { 1 }
    reading_started_at { "2025-04-06 17:10:09" }
    reading_ended_at { "2025-04-06 17:10:09" }
    duration_in_seconds { "2025-04-06 17:10:09" }
  end
end
