class Restaurant < ApplicationRecord
  has_many :tables
  has_many :shifts
  has_many :reservations, through: :tables

  validates :name, presence: true
  validates :phone, presence: true, format: { with: valid_phone_regex }
  validates :email, presence: true, format: { with: valid_email_regex }, uniqueness: { case_sensitive: false }
end
