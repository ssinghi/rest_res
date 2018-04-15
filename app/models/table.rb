class Table < ApplicationRecord
  belongs_to :restaurant

  has_many :reservations, dependent: :destroy

  validates :name, presence: true
  validates :restaurant, presence: true
  validates :min_guests, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :max_guests, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates_uniqueness_of :name, scope: :restaurant_id, case_sensitive: false

  validate :min_guests_less_than_or_equal_to_max_guests

  private

  def min_guests_less_than_or_equal_to_max_guests
    if min_guests && max_guests && max_guests < min_guests
      errors.add(:max_guests, "can't be less than min guests")
    end
  end
end
