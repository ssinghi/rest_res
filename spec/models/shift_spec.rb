require 'rails_helper'

RSpec.describe Shift, type: :model do
  context "validations" do
    let!(:shift) { create(:shift) }

    it { is_expected.to validate_presence_of(:restaurant) }
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:start_time) }
    it { is_expected.to validate_presence_of(:end_time) }
    it { is_expected.to validate_uniqueness_of(:name).scoped_to(:restaurant_id).case_insensitive }

    context "should validate that start time is after end time" do
      it "invalid case should have error" do
        shift.start_time = "11:00 am"
        shift.end_time   = "9:00 am"
        shift.valid?
        expect(shift.errors[:end_time]).to include("can't be before start time")
      end

      it "valid case should have no error" do
        shift.start_time   = "9:00 am"
        shift.end_time = "11:00 am"
        shift.valid?
        expect(shift.errors).to be_empty
      end
    end
  end
end
