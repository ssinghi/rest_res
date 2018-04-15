class Guest < ApplicationRecord
  has_many :reservations, dependent: :destroy

  validates :name, presence: true
  validates :email, presence: true, format: { with: valid_email_regex }, uniqueness: { case_sensitive: false }
end
