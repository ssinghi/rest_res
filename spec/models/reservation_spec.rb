require 'rails_helper'

RSpec.describe Reservation, type: :model do
  context "validations" do
    let!(:reservation) { create(:reservation) }

    it { is_expected.to validate_presence_of(:guest) }
    it { is_expected.to validate_presence_of(:shift) }
    it { is_expected.to validate_presence_of(:table) }
    it { is_expected.to validate_presence_of(:time) }
    it { is_expected.to validate_presence_of(:guests_count) }
    it { is_expected.to validate_numericality_of(:guests_count).only_integer.is_greater_than(0) }

    context "should ensure reservation time is during shift hours" do
      it "not valid if before shift starts" do
        reservation.time = reservation.shift.start_time - 1.hour
        reservation.valid?
        expect(reservation.errors[:time]).to include("can't be before the shift starts")
      end

      it "not valid if after shift ends" do
        reservation.time = reservation.shift.end_time + 1.hour
        reservation.valid?
        expect(reservation.errors[:time]).to include("can't be after the shift ends")
      end

      it "valid if during shift hours" do
        reservation.time = reservation.shift.start_time + 1.hour
        reservation.valid?
        expect(reservation.errors).to be_empty
      end
    end

    context "should ensure guests count is seatable" do
      it "not valid if less than table minimum" do
        reservation.guests_count = reservation.table.min_guests - 1
        reservation.valid?
        expect(reservation.errors[:guests_count]).to include("can't be less than table minimum")
      end

      it "not valid if more than table maximum" do
        reservation.guests_count = reservation.table.max_guests + 1
        reservation.valid?
        expect(reservation.errors[:guests_count]).to include("can't be more than table maximum")
      end

      it "valid if is in between table min and max" do
        reservation.table.min_guests.upto(reservation.table.max_guests).each do |count|
          reservation.guests_count = count
          reservation.valid?
          expect(reservation.errors).to be_empty
        end
      end
    end

    context "should ensure table is from same restaurant" do
      let(:another_table) { create(:table) }

      it "not valid if table is from another restaurant" do
        reservation.table = another_table
        reservation.valid?
        expect(reservation.errors[:table]).to include("can't be from different restaurant")
      end
    end

    context "should ensure no other prior reservation during that period" do
      let(:new_reservation) { reservation.dup }

      it "not valid if prior reservation was made for sometime earlier" do
        new_reservation.time = reservation.time + 10.minutes
        new_reservation.valid?
        expect(new_reservation.errors[:table]).to include("there is another reservation")
      end

      it "not valid if prior reservation was made for sometime later" do
        new_reservation.time = reservation.time - 10.minutes
        new_reservation.valid?
        expect(new_reservation.errors[:table]).to include("there is another reservation")
      end

      it "valid while updating reservation" do
        reservation.guests_count = 4
        reservation.valid?
        expect(reservation.errors).to be_empty
      end
    end
  end
end
