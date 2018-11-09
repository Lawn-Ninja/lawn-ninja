class Job < ApplicationRecord
  belongs_to :user
  validates :requested_time, presence: true
end
