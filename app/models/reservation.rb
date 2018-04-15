class Reservation < ApplicationRecord
  belongs_to :guest
  belongs_to :table
  belongs_to :shift

  validates :guest, presence: true
  validates :table, presence: true
  validates :shift, presence: true
  validates :time, presence: true
  validates :guests_count, presence: true, numericality: { only_integer: true, greater_than: 0 }

  validate :ensure_valid_reservation_time
  validate :ensure_seatable_guests_count
  validate :ensure_unique_reservation_for_table
  validate :ensure_table_is_from_correct_restaurant

  after_create :send_confirmation_email

  delegate :name, to: :guest, prefix: true
  delegate :name, to: :table, prefix: true

  private

  # within one hour of any existing reservation
  BUFFER_PERIOD = 1.hour
  def ensure_unique_reservation_for_table
    if time && shift && table
      reservations_on_same_table = shift.reservations.where(table_id: table.id)

      if id
        reservations_on_same_table = reservations_on_same_table.where.not(id: id)
      end

      if reservations_on_same_table.where("time > ? and time < ?", time - BUFFER_PERIOD, time + BUFFER_PERIOD).exists?
        errors.add(:table, "there is another reservation")
      end
    end
  end

  def ensure_table_is_from_correct_restaurant
    if shift && shift.restaurant != table.restaurant
      errors.add(:table, "can't be from different restaurant")
    end
  end

  def ensure_seatable_guests_count
    if guests_count && table
      if guests_count < table.min_guests
        errors.add(:guests_count, "can't be less than table minimum")
      elsif guests_count > table.max_guests
        errors.add(:guests_count, "can't be more than table maximum")
      end
    end
  end

  def ensure_valid_reservation_time
    if time && shift
      shift_start_time = shift.start_time.change(year: time.year, month: time.month, day: time.day)
      shift_end_time = shift.end_time.change(year: time.year, month: time.month, day: time.day)

      if time < shift_start_time
        errors.add(:time, "can't be before the shift starts")
      elsif time > shift_end_time
        errors.add(:time, "can't be after the shift ends")
      end
    end
  end

  def send_confirmation_email
    ReservationMailer.email_guest(self).deliver_later
    ReservationMailer.email_restaurant(self).deliver_later
  end
end
