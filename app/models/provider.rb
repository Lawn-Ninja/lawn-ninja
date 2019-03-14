class Provider < ApplicationRecord
  has_secure_password
  has_many :jobs
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false }
end
