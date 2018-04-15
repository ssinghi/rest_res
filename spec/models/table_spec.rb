require 'rails_helper'

RSpec.describe Table, type: :model do
  context "validations" do
    let!(:table) { create(:table) }

    it { is_expected.to validate_presence_of(:restaurant) }
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:min_guests) }
    it { is_expected.to validate_presence_of(:max_guests) }
    it { is_expected.to validate_numericality_of(:min_guests).only_integer.is_greater_than(0) }
    it { is_expected.to validate_numericality_of(:max_guests).only_integer.is_greater_than(0) }
    it { is_expected.to validate_uniqueness_of(:name).scoped_to(:restaurant_id).case_insensitive }

    context "should validate that min guests less than max_guests" do
      it "valid case should have no error" do
        table.min_guests = 2
        table.max_guests = 4
        table.valid?
        expect(table.errors).to be_empty
      end

      it "invalid case should have error" do
        table.min_guests = 4
        table.max_guests = 2
        table.valid?
        expect(table.errors[:max_guests]).to include("can't be less than min guests")
      end
    end
  end
end
