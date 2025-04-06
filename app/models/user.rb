class User < ApplicationRecord
  has_many :hrm_sessions
  has_many :hrm_data_points, through: :hrm_sessions

  validates :username, presence: true
  validates :gender, presence: true
  validates :age, presence: true
  validates :age, presence: true
  validates :hr_zone1_bpm_min, presence: true
  validates :hr_zone1_bpm_max, presence: true
  validates :hr_zone2_bpm_min, presence: true
  validates :hr_zone2_bpm_max, presence: true
  validates :hr_zone3_bpm_min, presence: true
  validates :hr_zone3_bpm_max, presence: true
end
