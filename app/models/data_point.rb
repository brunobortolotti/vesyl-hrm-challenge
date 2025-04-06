class DataPoint < ApplicationRecord
  belongs_to :session

  validates :session_id, presence: true
  validates :beats_per_minute, presence: true
  validates :reading_started_at, presence: true
  validates :reading_ended_at, presence: true
  validates :duration_in_seconds, presence: true
end
