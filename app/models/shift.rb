class Shift < ApplicationRecord
  belongs_to :restaurant

  has_many :reservations

  validates :name, presence: true
  validates :restaurant, presence: true
  validates :start_time, presence: true
  validates :end_time, presence: true
  validates_uniqueness_of :name, scope: :restaurant_id, case_sensitive: false

  validate :start_time_before_end_time_validation

  private

  def start_time_before_end_time_validation
    if start_time && end_time && end_time < start_time
      errors.add(:end_time, "can't be before start time")
    end
  end
end
