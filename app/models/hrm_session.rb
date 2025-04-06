class HrmSession < ApplicationRecord
  belongs_to :user
  has_many :hrm_data_points

  validates :user_id, presence: true
  validates :duration_in_seconds, presence: true
end
